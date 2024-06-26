import onnx
from onnx import numpy_helper
import numpy as np
onnx_model = onnx.load('mobilenetv2-10.onnx', load_external_data=False)
# HW2-2-1 ================================================================================
# The model is represented as a protobuf structure and it can be accessed
# using the standard python-for-protobuf methods
# output format --------------------------
# {"Conv_0" :{
#     "dilations" :[1, 1],
#     "group" :1,
#     "kernel_shape" :[3, 3],
#     "pads" :[1, 1, 1, 1],
#     "strides" :[2, 2]
#     }
# }
## list all the operator types in the model
node_list = []
count = []
nodes = []
for node in onnx_model.graph.node:
    if (node.op_type not in node_list):
        node_list.append(node.op_type)
        count.append(1)
        nodes.append(node)
        # print(node)
        print(f'{{"{node.op_type}": {{')
        if node.attribute:
            for j in node.attribute:
                attr_value = ""
                if j.type == onnx.AttributeProto.FLOAT:
                    attr_value = j.f
                elif j.type == onnx.AttributeProto.INT:
                    attr_value = j.i
                elif j.type == onnx.AttributeProto.STRING:
                    attr_value = j.s.decode('utf-8')  # Decoding byte string to normal string
                elif j.type == onnx.AttributeProto.FLOATS:
                    attr_value = list(j.floats)
                elif j.type == onnx.AttributeProto.INTS:
                    attr_value = list(j.ints)
                elif j.type == onnx.AttributeProto.STRINGS:
                    attr_value = [s.decode('utf-8') for s in j.strings]
                if j.type == onnx.AttributeProto.TENSOR:
                    tensor = j.t
                    attr_value = f"{{\n\t\tdata_type: {tensor.data_type},\n" \
                                 f"\t\traw_data: {str(tensor.raw_data)}"
                print(f'\t"{j.name}"  : {attr_value},')
            print("\t}\n}")
        else:
            print("\tThere's no attribute in this operator\n\t}\n}")
    else:
        idx = node_list.index(node.op_type)
        count[idx] = count[idx]+1
# verify output:
# for node in nodes:
#     print(node)
# print(node_list)
# print(count)

# HW2-2-2 ================================================================================

from onnx import shape_inference
from os import path
import sys
from tabulate import tabulate
from onnx import onnx_ml_pb2 as xpb2


onnx_model = onnx.load("mobilenetv2-10.onnx", load_external_data=False)
onnx.checker.check_model(onnx_model)

inferred_model = shape_inference.infer_shapes(onnx_model)
# print('shape inference complete ...')

def _parse_element(elem: xpb2.ValueInfoProto):
    name = getattr(elem, 'name', "None")
    # print(elem)
    data_type = "NA"
    shape_str = "NA"
    etype = getattr(elem, 'type', False)
    if etype:
        ttype = getattr(etype, 'tensor_type', False)
        if ttype:
            data_type = getattr(ttype, 'elem_type', 0)
            shape = getattr(elem.type.tensor_type, "shape", False)
            if shape:
                shape_str = "["
                dims = getattr(shape, 'dim', [])
                for dim in dims:
                    # print(dim)
                    vals = getattr(dim, 'dim_value', "?")
                    # print(vals)
                    if vals == 0:
                        vals = 1
                    # print(f'vals = {vals}')
                    shape_str += (str(vals) + ",")
                    # print(f'shape_str = {shape_str}')
                shape_str = shape_str.rstrip(",")
                shape_str += "]"
    return name, data_type, shape_str

def get_valueproto_or_tensorproto_by_name(name: str, graph: xpb2.GraphProto):
    for i, node in enumerate(inferred_model.graph.node):
            if node.name == "":
                inferred_model.graph.node[i].name = str(i)
    input_nlist = [k.name for k in graph.input]
    initializer_nlist = [k.name for k in graph.initializer]
    value_info_nlist = [k.name for k in graph.value_info]
    output_nlist = [k.name for k in graph.output]

    # get tensor data
    if name in input_nlist:
        idx = input_nlist.index(name)
        return graph.input[idx], int(1)
    elif name in value_info_nlist:
        idx = value_info_nlist.index(name)
        return graph.value_info[idx], int(2)
    elif name in initializer_nlist:
        idx = initializer_nlist.index(name)
        return graph.initializer[idx], int(3)
    elif name in output_nlist:
        idx = output_nlist.index(name)
        return graph.output[idx], int(4)
    else:
        print("[ERROR MASSAGE] Can't find the tensor: ", name)
        # print('input_nlist:\n', input_nlist)
        # print('===================')
        # print('value_info_nlist:\n', value_info_nlist)
        # print('===================')
        # print('initializer_nlist:\n', initializer_nlist)
        # print('===================')
        # print('output_nlist:\n', output_nlist)
        # print('===================')
        return False, 0

def cal_tensor_mem_size(elem_type: str, shape: [int]):
    """ given the element type of the tensor and its shape, and return its memory size.

    Utility.

    Args:
        ttype: the type of the element of the given tensor. format: 'int', ...
        shape: the shape of the given tensor. format: [] of int

    Returns:
        mem_size: int
    """
    # init
    mem_size = int(1)
    # traverse the list to get the number of the elements
    for num in shape:
        mem_size *= num
    # multiple the size of variable with the number of the elements
    # "FLOAT": 1,
    # "UINT8": 2,
    # "INT8": 3,
    # "UINT16": 4,
    # "INT16": 5,
    # "INT32": 6,
    # "INT64": 7,
    # # "STRING" : 8,
    # "BOOL": 9,
    # "FLOAT16": 10,
    # "DOUBLE": 11,
    # "UINT32": 12,
    # "UINT64": 13,
    # "COMPLEX64": 14,
    # "COMPLEX128": 15
    # print(f'elem_type = {elem_type}')
    if elem_type == 1:
        mem_size *= 4
    elif elem_type == 2:
        mem_size *= 1
    elif elem_type == 3:
        mem_size *= 1
    elif elem_type == 4:
        mem_size *= 2
    elif elem_type == 5:
        mem_size *= 2
    elif elem_type == 6:
        mem_size *= 4
    elif elem_type == 7:
        mem_size *= 8
    elif elem_type == 9:
        mem_size *= 1
    elif elem_type == 10:
        mem_size *= 2
    elif elem_type == 11:
        mem_size *= 8
    elif elem_type == 12:
        mem_size *= 4
    elif elem_type == 13:
        mem_size *= 8
    elif elem_type == 14:
        mem_size *= 8
    elif elem_type == 15:
        mem_size *= 16
    else:
        print("Undefined data type")
    # print(f'mem_size = {mem_size}')
    return mem_size



def get_bandwidth(graph: xpb2.GraphProto):
    try:
        mem_BW_list = []
        total_mem_BW = 0
        unknown_tensor_list = []
        # traverse all the nodes
        for nodeProto in graph.node:
            # init variables
            read_mem_BW_each_layer = 0
            write_mem_BW_each_layer = 0
            total_each_layer = 0
            # traverse all input tensor
            for input_name in nodeProto.input:
                # get the TensorProto/ValueInfoProto by searching its name
                proto, type_Num = get_valueproto_or_tensorproto_by_name(
                    input_name, graph)
                # parse the ValueInfoProto/TensorProto
                if proto:
                    if type_Num == 3:
                        dtype = getattr(proto, 'data_type', False)
                        # get the shape of the tensor
                        shape = getattr(proto, 'dims', [])
                    elif type_Num == 1 or type_Num == 2:
                        name, dtype, shape_str = _parse_element(proto)
                        shape_str = shape_str.strip('[]')
                        shape_str = shape_str.split(',')
                        shape = []
                        for dim in shape_str:
                            if dim != '':
                                shape.append(int(dim))
                    else:
                        print(
                            '[ERROR MASSAGE] [get_info/mem_BW_without_buf] The Tensor: ',
                            input_name, ' is from a wrong list !')
                else:
                    print(
                        '[ERROR MASSAGE] [get_info/mem_BW_without_buf] The Tensor: ',
                        input_name, ' is no found !')
                    unknown_tensor_list.append(
                        (nodeProto.name, input_name, nodeProto.op_type))
                # calculate the tensor size in btye
                # print("hello next")
                read_mem_BW_each_layer += cal_tensor_mem_size(dtype, shape)

            # traverse all output tensor
            for output_name in nodeProto.output:
                # get the TensorProto/ValueInfoProto by searching its name
                proto, type_Num = get_valueproto_or_tensorproto_by_name(
                    output_name, graph)
                # parse the ValueInfoProto
                if proto:
                    if type_Num == 2 or type_Num == 4:
                        # name, dtype, shape = utils._parse_ValueInfoProto(proto)
                        name, dtype, shape_str = _parse_element(proto)
                        # print(f'shape_str = {shape_str}')
                        # print(f'dtype = {dtype}')
                        shape_str = shape_str.strip('[]')
                        shape_str = shape_str.split(',')
                        shape = []
                        for dim in shape_str:
                            if dim != '':
                                shape.append(int(dim))
                    else:
                        print(
                            '[ERROR MASSAGE] [get_info/mem_BW_without_buf] The Tensor: ',
                            output_name, ' is from a wrong list !')
                else:
                    print(
                        '[ERROR MASSAGE] [get_info/mem_BW_without_buf] The Tensor: ',
                        input_name, ' is no found !')
                    unknown_tensor_list.append(
                        (nodeProto.name, output_name, nodeProto.op_type))
                # calculate the tensor size in btye
                # print("hello next")
                write_mem_BW_each_layer += cal_tensor_mem_size(dtype, shape)

            # cal total bw
            total_each_layer = read_mem_BW_each_layer + write_mem_BW_each_layer

            # store into tuple
            temp_tuple = (nodeProto.name, read_mem_BW_each_layer,
                        write_mem_BW_each_layer, total_each_layer)
            #append it
            mem_BW_list.append(temp_tuple)
            # accmulate the value
            total_mem_BW += total_each_layer

        # display the mem_bw of eahc layer
        columns = ['layer', 'read_bw', 'write_bw', 'total_bw']
        # resort the list
        mem_BW_list = sorted(mem_BW_list,
                             key=lambda Layer: Layer[1],
                             reverse=True)
        print(tabulate(mem_BW_list, headers=columns))
        print(
            '====================================================================================\n'
        )
        # display it
        print(
            "The memory bandwidth for processor to execute a whole model without on-chip-buffer is: \n",
            total_mem_BW, '(bytes)\n',
            float(total_mem_BW) / float(1000000), '(MB)\n')
        # display the unknown tensor
        columns = ['op_name', 'unfound_tensor', 'op_type']
        print(tabulate(unknown_tensor_list, headers=columns))
        print(
            '====================================================================================\n'
        )
    except Exception as e:
        print("[ERROR MASSAGE] Unable to display: " + str(e))
        return False

    return True

get_bandwidth(inferred_model.graph)

# HW2-2-3 ================================================================================
# Assuming the activations are stored to local memory and
# reuse multiple times, how much local memory storage is required to
# keep the activations?
# Define a hook function
import torchvision.models as models
import torch
def get_activation(name):
    def hook(model, input, output):
        activation[name] = output.detach()
        # print(output.dtype)
        if output.dtype == torch.int8:
            memory_size = output.nelement() * 1
        elif output.dtype == torch.int16 or output.dtype == torch.float16:
            memory_size = output.nelement() * 2
        elif output.dtype == torch.int32 or output.dtype == torch.float32:
            memory_size = output.nelement() * 4
        elif output.dtype == torch.int64 or output.dtype == torch.float64:
            memory_size = output.nelement() * 8
        activation_sizes.append(memory_size)
        # print(f'memory_size = {memory_size}, output.dtype = {output.dtype}')
    return hook


# Dictionary to store activations from each layer
activation = {}
activation_sizes = []
model = models.mobilenet_v2(pretrained=True)
model.eval()
# Register hook to each linear layer
for layer_name, layer in model.named_modules():
    # if isinstance(layer, torch.nn.Linear):
    #     # Register forward hook
    layer.register_forward_hook(get_activation(layer_name))

# Run model inference
data = torch.randn(1, 3, 224, 224)
output = model(data)
total_memory = sum(activation_sizes)
print(f'total local memory storage required = {total_memory}')
# Access the saved activations
# for layer in activation:
#     print(f"Activation from layer {layer}: {activation[layer].shape}")