#include <torch/script.h> // One-stop header.

#include <iostream>
#include <memory>
#include <vector>
#include <string>
#include <queue>

int classifier_count = 0;
size_t total_activation_size = 0;
std::queue<std::string> conv_layer;
std::queue<std::string> linear_layer;
// analyze the graph, and push the target module name to \
   features_activations and classifier_activations
void find_conv_linear(torch::jit::script::Module& module){
    for (const auto& submodule : module.named_modules()) {
        // std::cout << "Module name: " << submodule.name << std::endl;
        if (submodule.name == "features" || submodule.name == "classifier") {
            auto current_module = submodule.value;
            for (const auto& method : current_module.get_methods()) {
                auto graph = method.graph();
                // std::cout << "current graph: " << graph->toString() << std::endl;
                for (const auto& node : graph->nodes()) {
                    // example : Output node: _5, Type: __torch__.torch.nn.modules.activation.___torch_mangle_13.ReLU
                    for (const torch::jit::Value* output : node->outputs()) {
                        auto type_ptr = output->type();
                        std::string type_str = type_ptr->str();
                        if (type_str.find("__torch__.torch.nn.modules.conv") != std::string::npos) {
                            // The type string contains "__torch__.torch.nn.modules.activation"
                            // std::cout << "The node is an activation function: " << output->debugName() << std::endl;
                            if (submodule.name == "features") {
                                std::string number_part = (output->debugName()).substr(1);
                                std::string module_name = "features." + number_part;
                                conv_layer.push(module_name);
                                // std::cout << "module_name created = " << number_part << "\n";

                            }
                        }
                        else if (type_str.find("__torch__.___torch_mangle_12.CustomLinear") != std::string::npos) {
                            // The type string contains "__torch__.torch.nn.modules.activation"
                            // std::cout << "The node is an activation function: " << output->debugName() << std::endl;
                            if (submodule.name == "classifier") {
                                std::string number_part = (output->debugName()).substr(1);
                                std::string module_name = "classifier." + number_part;
                                linear_layer.push(module_name);
                                // std::cout << "module_name created = " << number_part << "\n";

                            }
                        }
                    }
                }
            }
        }
    }
}
int forwarding = 0;
torch::Tensor run_model_recursively(torch::jit::script::Module module, torch::Tensor input){
    torch::Tensor output = input;
    // std::cout << "hi , forwarding = " << forwarding << std::endl;
    for (auto submodule : module.named_modules()) {
        // std::cout << "Processing module: " << submodule.name << std::endl;
        // std::cout << "classifier_count: " << classifier_count << std::endl;
        if(submodule.name != "" && \
           submodule.name != "features" && submodule.name != "classifier"){
            output = run_model_recursively(submodule.value, output);
            // std::cout << "Output size = " << output.sizes() << std::endl;
            total_activation_size += (output.numel() * output.element_size());
            // flatten
            if(submodule.name == "classifier.0"){
                output = output.view({output.size(0), -1});
            }
            // hw2-4-3
            // if(submodule.name == conv_layer.front()){
            //     std::cout << "match conv_layer!\n";
            //     auto padding = submodule.value.attr("padding");
            //     if (padding.isInt()) {
            //         std::cout << "Padding size: " << padding.toInt() << "\n";
            //     }
            //     else if (padding.isIntList()) {
            //         auto pads = padding.toIntList();
            //         std::cout << "Padding sizes: ";
            //         for (const auto& p : pads) {
            //             std::cout << p << " ";
            //         }
            //         std::cout << "\n";
            //     }
            // }
            if (submodule.name.find("classifier.") != std::string::npos){
                classifier_count--;
            }
            if(!classifier_count){
                break;
            }
        }
    }
    if (classifier_count) {
        output = module.forward({output}).toTensor();
        // std::cout << "Output size: " << output.sizes() << std::endl;
        forwarding++;
    }
    return output;
}
void print_debug_contents(torch::jit::script::Module& module){
    auto graph = module.get_method("forward").graph();
    std::cout << graph->toString() << std::endl;
    auto features = module.attr("features").toModule();
    auto avgpool = module.attr("avgpool").toModule();
    auto classifier = module.attr("classifier").toModule();
    auto print_module_details = [](const torch::jit::script::Module& module, const std::string& name) {
        std::cout << "Details of " << name << " module:" << std::endl;
        for (const auto& param : module.named_parameters()) {
            std::cout << "Parameter name: " << param.name << std::endl;
            std::cout << "Parameter tensor size: " << param.value.sizes() << std::endl;
        }

        for (const auto& buffer : module.named_buffers()) {
            std::cout << "Buffer name: " << buffer.name << std::endl;
            std::cout << "Buffer tensor size: " << buffer.value.sizes() << std::endl;
        }
    };
    for (const auto& submodule : module.named_modules()) {
        std::cout << "Module name: " << submodule.name << std::endl;
        if (submodule.name == "features" || submodule.name == "classifier") {
            auto current_module = submodule.value;
            for (const auto& method : current_module.get_methods()) {
                auto graph = method.graph();
                std::cout << "current graph: " << graph->toString() << std::endl;
                for (const auto& node : graph->nodes()) {
                    // Node kind : prim::GetAttr
                    std::cout << "Node kind: " << node->kind().toQualString() << std::endl;

                    for (const torch::jit::Value* input : node->inputs()) {
                        std::cout << "Input node: " << input->debugName() << std::endl;
                        if (input->node()->kind() == torch::jit::prim::GetAttr) {
                            std::cout << "Input node kind: " << input->node()->kind().toQualString() << std::endl;
                            std::cout << "Input node name: " << input->node()->s(torch::jit::attr::name) << std::endl;
                        }
                    }
                    // example : Output node: _5, Type: __torch__.torch.nn.modules.activation.___torch_mangle_13.ReLU
                    for (const torch::jit::Value* output : node->outputs()) {
                        auto type_ptr = output->type();
                        std::cout << "Output node: " << output->debugName() << \
                                     ", Type: " << *type_ptr << std::endl;
                        std::string type_str = type_ptr->str(); // Convert TypePtr to string
                        if (type_str.find("__torch__.torch.nn.modules.activation") != std::string::npos) {
                            // The type string contains "__torch__.torch.nn.modules.activation"
                            std::cout << "The node is an activation function: " << output->debugName() << std::endl;
                        }
                    }
                }
            }
        }

    }
    print_module_details(features, "Features");
    print_module_details(avgpool, "AvgPool");
    print_module_details(classifier, "Classifier");
    return;
}

int main(int argc, const char* argv[]) {
    if (argc != 2) {
    std::cerr << "usage: example-app <path-to-exported-script-module>\n";
    return -1;
    }


    torch::jit::script::Module module;
    try {
    // Deserialize the ScriptModule from a file using torch::jit::load().
    module = torch::jit::load(argv[1]);
    module.eval();
    }
    catch (const c10::Error& e) {
    std::cerr << "error loading the model\n";
    return -1;
    }

    std::cout << "load the torchscript model, " + std::string(argv[1]) + ", successfully \n";

    /*
        HW 2-4 Using Pytorch C++ API to do model analysis on the transformed model graph
        Before you start this homework,
        you need to store the transformed model graph from HW2-3 in the torch script
        format as mentioned in Lab 2-4.
    */
    // 2-4-1. Calculate memory requirements for storing the model weights.
    torch::jit::named_parameter_list param_list = module.named_parameters();
    int total_size = 0;
    for (const auto& it : param_list) {
        const at::Tensor& tensor = it.value;
        if (it.name.find("weight") != std::string::npos) {
            // std::cout << "Parameter name: " << it.name << std::endl;
            total_size += tensor.numel() * tensor.element_size();
        }
    }
    std::cout << "memory requirements for storing the model weights = " << total_size << "\n";

    // 2-4-2. Calculate memory requirements for storing the activations
    // 2-4-3. Calculate computation requirements
    std::vector<at::Tensor> activations;
    torch::Tensor input = torch::randn({10, 3, 224, 224});
    for (const auto& submodule : module.named_modules()) {
        // std::cout << "Module name: " << submodule.name << std::endl;
        if (submodule.name.find("classifier.") != std::string::npos) {
            // Increment count if "classifier." is found in the module name
            classifier_count++;
            // std::cout << "classifier_count = " << classifier_count << "\n";
        }
    }
    find_conv_linear(module);
    run_model_recursively(module, input);
    std::cout << "Total memory requirements for storing the activations: " << total_activation_size << " bytes" << std::endl;

    return 0;

}
