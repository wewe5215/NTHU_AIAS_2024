import torchvision.models as models
from torchvision import models
from torchsummary import summary
import torchinfo
import torch.nn as nn
import torch
# 加載 GoogLeNet 模型
# model = models.googlenet(pretrained=True)
# print(model)
# input_shape = (3, 224, 224)

## 2-1-1. Calculate the number of model parameters：
### Please include all trainable and non-trainable parameters

model = models.googlenet(pretrained=True)
summary(model, (3, 224, 224))

## 2-1-2. Calculate memory requirements for storing the model weights.
# manual_calc = 0
# for name, p in model.named_parameters():
#     if "weight" in name:
#         # print(name)
#         # print(p)
#         manual_calc += p.numel() * p.element_size()
# print("manual_calc:")
# print(manual_calc)
sum_calc = sum(p.numel() * p.element_size() for name, p in model.named_parameters() if 'weight' in name)
print("memory requirements for storing the model weights:")
print(sum_calc)
## 2-1-3. Use Torchinfo to print model architecture including the number of parameters and the output activation size of each layer

torchinfo.summary(model, input_size=(1, 3, 224, 224), col_names=("num_params", "output_size"), verbose=1)
## 2-1-4. Calculate computation requirements
# The primary focus is on calculating MACs for linear and convolutional layers, with calculations for other layers being a bonus.

def calculate_output_shape(input_shape, layer):
    # Calculate the output shape for Conv2d, MaxPool2d, and Linear layers
    if isinstance(layer, (nn.Conv2d, nn.MaxPool2d)):
        kernel_size = (
            layer.kernel_size
            if isinstance(layer.kernel_size, tuple)
            else (layer.kernel_size, layer.kernel_size)
        )
        stride = (
            layer.stride
            if isinstance(layer.stride, tuple)
            else (layer.stride, layer.stride)
        )
        padding = (
            layer.padding
            if isinstance(layer.padding, tuple)
            else (layer.padding, layer.padding)
        )
        dilation = (
            layer.dilation
            if isinstance(layer.dilation, tuple)
            else (layer.dilation, layer.dilation)
        )

        output_height = (
            input_shape[1] + 2 * padding[0] - dilation[0] * (kernel_size[0] - 1) - 1
        ) // stride[0] + 1
        output_width = (
            input_shape[2] + 2 * padding[1] - dilation[1] * (kernel_size[1] - 1) - 1
        ) // stride[1] + 1
        return (
            layer.out_channels if hasattr(layer, "out_channels") else input_shape[0],
            output_height,
            output_width,
        )
    elif isinstance(layer, nn.Linear):
        # For Linear layers, the output shape is simply the layer's output features
        return (layer.out_features,)
    else:
        return input_shape


def calculate_macs(layer, input_shape, output_shape):
    # Calculate MACs for Conv2d and Linear layers
    if isinstance(layer, nn.Conv2d):
        kernel_ops = (
            layer.kernel_size[0]
            * layer.kernel_size[1]
            * (layer.in_channels / layer.groups)
        )
        output_elements = output_shape[1] * output_shape[2]
        macs = int(kernel_ops * output_elements * layer.out_channels)
        return macs
    elif isinstance(layer, nn.Linear):
        # For Linear layers, MACs are the product of input features and output features
        macs = int(layer.in_features * layer.out_features)
        return macs
    else:
        return 0
# Initial input shape
input_shape = (3, 224, 224)
total_macs = 0

# Iterate through the layers of the model
for name, layer in model.named_modules():
    # print(name)
    # print(layer)
    if isinstance(layer, (nn.Conv2d, nn.MaxPool2d, nn.BatchNorm2d, nn.Linear, nn.AdaptiveAvgPool2d, nn.Dropout)):
        output_shape = calculate_output_shape(input_shape, layer)
        macs = calculate_macs(layer, input_shape, output_shape)
        total_macs += macs
        if isinstance(layer, (nn.Conv2d, nn.Linear)):
            print(
                f"Layer: {name}, Type: {type(layer).__name__}, Input Shape: {input_shape}, Output Shape: {output_shape}, MACs: {macs}"
            )
        # elif isinstance(layer, nn.MaxPool2d):
        #     # Also print shape transformation for MaxPool2d layers (no MACs calculated)
        #     print(
        #         f"Layer: {name}, Type: {type(layer).__name__}, Input Shape: {input_shape}, Output Shape: {output_shape}, MACs: N/A"
        #     )
        else:
            print(
                f"Layer: {name}, Type: {type(layer).__name__}, Input Shape: {input_shape}, Output Shape: {output_shape}, MACs: N/A"
            )
        input_shape = output_shape  # Update the input shape for the next layer

print(f"Total MACs: {total_macs}")

## 2-1-5. Use forward hooks to extract the output activations of the Conv2d layers.
# Define a hook function
def get_activation(name):
    def hook(model, input, output):
        activation[name] = output.detach()
    return hook


# Dictionary to store activations from each layer
activation = {}

# Register hook to each Conv2d layer
for layer_name, layer in model.named_modules():
    if isinstance(layer, torch.nn.Conv2d):
        # Register forward hook
        layer.register_forward_hook(get_activation(layer_name))

# Run model inference
data = torch.randn(1, 3, 224, 224)
output = model(data)

# Access the saved activations
for layer in activation:
    print(f"Activation from layer {layer}: {activation[layer].shape}")