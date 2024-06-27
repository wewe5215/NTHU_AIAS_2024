# (NTHU_109062320_朱季葳) AIAS 2024 Lab 2 HW Submission

[toc]

## Gitlab code link

- Gitlab link - 
https://course.playlab.tw/git/wewe5215/lab2

## HW 2-1 Model Analysis Using Pytorch

### 2-1-1. Calculate the number of model parameters：

#### Code
```python=
# 在這裡直接使用summary來print出結果，就跟tutorial一樣
model = models.googlenet(pretrained=True)
summary(model, (3, 224, 224))
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/1dd796b0-a317-4b6f-bdf4-936a190d1b49.png)

![](https://course.playlab.tw/md/uploads/bd057ac5-d2cf-42a4-a4f7-274de9181eed.png)


### 2-1-2. Calculate memory requirements for storing the model weights.
#### Code
```python=
# 因為要算weight的memory requirement所以如果該parameter的名字有weight就算他的size然後加總
sum_calc = sum(p.numel() * p.element_size() for name, p in model.named_parameters() if 'weight' in name)
print("memory requirements for storing the model weights:")
print(sum_calc)
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/f99420da-7c63-4fb4-9bc1-df6c51c4e244.png)



### 2-1-3. Use Torchinfo to print model architecture including the number of parameters and the output activation size of each layer 
#### Code
```python=
# 這裡是用torchinfo的summary並依據題目要求印出包含parameter數量("num_params")
# 還有每個layer的output activation size
import torchinfo
torchinfo.summary(model, input_size=(1, 3, 224, 224), col_names=("num_params", "output_size"), verbose=0)
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/e82134bf-4757-4148-8d26-bb49c736819e.png)
![](https://course.playlab.tw/md/uploads/e8d745f0-7c19-41ec-a229-4a2d68bd52ab.png)



### 2-1-4. Calculate computation requirements
#### Code
```python=
# 在這裡基本上就是沿用tutorial的code然後再加上Conv2d的部分，取得計算MACs需要的data然後算出來得到結果
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

    if isinstance(layer, (nn.Conv2d, nn.MaxPool2d, nn.BatchNorm2d, nn.Linear, nn.AdaptiveAvgPool2d, nn.Dropout)):
        output_shape = calculate_output_shape(input_shape, layer)
        macs = calculate_macs(layer, input_shape, output_shape)
        total_macs += macs
        if isinstance(layer, (nn.Conv2d, nn.Linear)):
            print(
                f"Layer: {name}, Type: {type(layer).__name__}, Input Shape: {input_shape}, Output Shape: {output_shape}, MACs: {macs}"
            )
        else:
            print(
                f"Layer: {name}, Type: {type(layer).__name__}, Input Shape: {input_shape}, Output Shape: {output_shape}, MACs: N/A"
            )
        input_shape = output_shape  # Update the input shape for the next layer

print(f"Total MACs: {total_macs}")

```

#### Execution Result
![](https://course.playlab.tw/md/uploads/dcf22e18-1f07-4022-aa2e-721b8e1c5ffe.png) 
![](https://course.playlab.tw/md/uploads/0c422032-e4bf-4b86-9829-820d0a9508e3.png)
    


### 2-1-5. Use forward hooks to extract the output activations of  the Conv2d layers.
#### Code
```python=
# 在這裡把每個Conv2d的layer抓出來然後使用
# forward hook取得他的activations(這個也是從tutorial那邊小改的)
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
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/6de20ef0-d188-4fe6-ad38-eda6db8caf83.png)


## HW 2-2 Add more statistics to analyze the an ONNX model Using sclblonnx

### 2-2-1. model characteristics
#### Code
```python=
node_list = []
count = []
nodes = []
# 在這裡首先traverse整個graph的node然後如果這個node的op_type
# 沒有出現過就把node放進node_list避免重複，接著traverse
# 每個node的attribute，並根據他的型別來把相對應的data 
# assign到attr_value，而如果沒有attribute的話就
# print "There's no attribute in this operator"
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
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/43828e0e-92c5-4453-b7c6-6d06615bef75.png)


### 2-2-2. Data bandwidth requirement 
#### Code
```python=
# 這個部分是基於tutorial中計算bandwidth的那個程式進行改編的，
# 其中修改的部分有以下兩點：
# 1. 在_parse_element(elem: xpb2.ValueInfoProto)的部分
# 因為batch size是沒有指定的，所以在下面處理dims的時候會出錯，
# 而在slack上有同學詢問到相關的問題(在沒有指定時把batch size設為1)，
# 所以在這裡就是加上相對應的處理
# 2. 第二點是在parse完element過後，可能會遇到shape_str裡面的dim是
# 空字元而報錯，所以在這邊加上判定的部分以及處理
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
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/d84f0883-9584-4fad-899b-5979e7f6b6b7.png)
![](https://course.playlab.tw/md/uploads/badd9e44-12b5-4366-a294-08304b3a979c.png)


### 2-2-3. activation memory storage requirement
#### Code
```python=
# 在這裡的部分跟2-1-5非常相似，
# 只是在這邊有根據output的data type去做
# memory storage requirement的計算
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
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/5b56f292-6845-4a69-b00b-9c4030c47c07.png)


## HW 2-3 Build tool scripts to manipulate an ONNX model graph

### 2-3-1. create a subgraph (1) that consist of a single Linear layer of size MxKxN

#### Code
```python=
# 在這裡基本上就是照著spec上面給的圖去刻，然後再make graph跟model
A_mat = helper.make_tensor_value_info('A',  TensorProto.FLOAT,  [128, 128])
B_mat = helper.make_tensor_value_info('B',  TensorProto.FLOAT,  [128, 128])

# output
C_mat = helper.make_tensor_value_info('C',  TensorProto.FLOAT,  [128, 128])

node1 = helper.make_node('MatMul', ['A', 'B'], ['C'])

graph = helper.make_graph([node1],
                    'lr',  # a name
                    [A_mat, B_mat],
                    [C_mat])  # outputs

onnx_model = helper.make_model(graph)

onnx.checker.check_model(onnx_model)
onnx.save(onnx_model, 'subgraph1.onnx')
```

#### Visualize the subgraph (1)
![](https://course.playlab.tw/md/uploads/9618321b-ef1d-44d1-b5ab-2e7f1ff594d8.png)


### 2-3-2. create a subgraph (2) as shown in the above diagram for the subgraph (1)  

#### Code
```python=
# 在這題其實也是照著spec上的圖刻，要到下一題才會有
# in general case劃分成64x64 submatrix的作法。
# 而這裡首先是處理input的部分(沿用tutorial的_parse_element(elem))，
# 要traverse所有input並做split(以這題要切所有input的情境之下)，
# 而因為split一次只能切一個方向，所以先上下切再左右切，
# 然後再去做乘、加法的運算，最後再concate在一起
from onnx import numpy_helper
def _parse_element(elem):
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
                shape_str = [ ]
                dims = getattr(shape, 'dim', [])
                for dim in dims:
                    # print(dim)
                    vals = getattr(dim, 'dim_value', "?")
                    # print(vals)
                    if vals == 0:
                        vals = 1
                    # print(f'vals = {vals}')
                    shape_str.append(vals)
                    # print(f'shape_str = {shape_str}')
    return name, data_type, shape_str

def calculate_submatrix(inputs):
    new_nodes = []
    for input in inputs:
        name, dtype, shape_str = _parse_element(input)
        dim_x = shape_str[0]
        dim_y = shape_str[1]
        name_0 = name + 'top'
        name_1 = name + 'bottom'
        name_00 = name + '00'
        name_01 = name + '01'
        name_10 = name + '10'
        name_11 = name + '11'
        sub0 = helper.make_node(
            'Split',
            inputs=[name],
            outputs=[name_0, name_1],
            axis=0,
            split=[64, 64]
        )
        new_nodes.append(sub0)
        sub1 = helper.make_node(
            'Split',
            inputs=[name_0],
            outputs=[name_00, name_01],
            axis=1,
            split=[64, 64]
        )
        new_nodes.append(sub1)
        sub2 = helper.make_node(
            'Split',
            inputs=[name_1],
            outputs=[name_10, name_11],
            axis=1,
            split=[64, 64]
        )
        new_nodes.append(sub2)
    # 𝐶00= 𝐴00∗𝐵00 + 𝐴01∗𝐵10
    mul0 = helper.make_node('MatMul', ['A00', 'B00'], ['mul000'])
    mul1 = helper.make_node('MatMul', ['A01', 'B10'], ['mul001'])
    add0 = helper.make_node('Sum', ['mul000', 'mul001'], ['C00'])
    # 𝐶01=𝐴00∗𝐵01 + 𝐴01∗𝐵11
    mul2 = helper.make_node('MatMul', ['A00', 'B01'], ['mul010'])
    mul3 = helper.make_node('MatMul', ['A01', 'B11'], ['mul011'])
    add1 = helper.make_node('Sum', ['mul010', 'mul011'], ['C01'])

    concat0 = helper.make_node('Concat', ['C00', 'C01'], ['C0'], axis=1)
    # 𝐶10=𝐴10∗𝐵00 + 𝐴11∗𝐵10
    mul4 = helper.make_node('MatMul', ['A10', 'B00'], ['mul100'])
    mul5 = helper.make_node('MatMul', ['A11', 'B10'], ['mul101'])
    add2 = helper.make_node('Sum', ['mul100', 'mul101'], ['C10'])
    # 𝐶11=𝐴10∗𝐵01 + 𝐴11∗𝐵11
    mul6 = helper.make_node('MatMul', ['A10', 'B01'], ['mul110'])
    mul7 = helper.make_node('MatMul', ['A11', 'B11'], ['mul111'])
    add3 = helper.make_node('Sum', ['mul110', 'mul111'], ['C11'])

    concat1 = helper.make_node('Concat', ['C10', 'C11'], ['C1'], axis=1)
    concat2 = helper.make_node('Concat', ['C0', 'C1'], ['C'], axis=0)

    new_nodes.append(mul0)
    new_nodes.append(mul1)
    new_nodes.append(mul2)
    new_nodes.append(mul3)
    new_nodes.append(mul4)
    new_nodes.append(mul5)
    new_nodes.append(mul6)
    new_nodes.append(mul7)

    new_nodes.append(add0)
    new_nodes.append(add1)
    new_nodes.append(add2)
    new_nodes.append(add3)

    new_nodes.append(concat0)
    new_nodes.append(concat1)
    new_nodes.append(concat2)
    graph2 = helper.make_graph(new_nodes,
                        'lr2',  # a name
                        [A_mat, B_mat],
                        [C_mat])  # outputs
    return graph2

new_graph = calculate_submatrix(graph.input)
# onnx_model2 = helper.make_model(graph2)
opset_version = 11  # newer, based on ONNX operator support
onnx_model2 = helper.make_model(new_graph, opset_imports=[helper.make_opsetid("", opset_version)])

onnx.checker.check_model(onnx_model2)
onnx.save(onnx_model2, 'subgraph2.onnx')

```

#### Visualize the subgraph (2)
![](https://course.playlab.tw/md/uploads/ed3331ef-fdfd-4d5c-b48a-39fcdeeee5b1.png)



### 2-3-3. replace the `Linear` layers in the AlexNet with the equivalent subgraphs (2)
#### Code
```python=
from onnx import shape_inference
onnx_model3 = onnx.load('alexnet.onnx', load_external_data=False)
graph3 = onnx_model3.graph
new_nodes = [ ]
new_tensors = [ ]
inferred_model = shape_inference.infer_shapes(onnx_model3)
debugging = 1

def do_64x64_operation(A, B, bias, output, A_row_count, A_col_count, B_col_count, original_dim_x, original_dim_y):
    # 以64x64的submatrix為基本單位做矩陣乘法
    # 左上角的output叫A_mul_B_0_0
    current_nodes = []
    for i in range(A_row_count):
        for j in range(B_col_count):
            result = A + '_mul_' + B + str(i) + '_' + str(j)
            for k in range(A_col_count):
                operand0 = A + str(i) + '_' + str(k)
                operand1 = B + str(k) + '_' + str(j)
                cur_result = A + '_' + B + '_' + str(i) + '_' + str(j) + '_' + str(k)
                A_mul_B = helper.make_node('MatMul', [operand0, operand1], [cur_result])
                new_nodes.append(A_mul_B)
                # 進行連加
                if k == 1:
                    add_up = helper.make_node('Sum', [A + '_' + B + '_' + str(i) + '_' + str(j) + '_' + str(k - 1), cur_result], [A + '_mul_' + B + str(i) + '_' + str(j) + '_' + str(k)])
                    new_nodes.append(add_up)
                elif k > 1 and k != (A_col_count - 1):
                    add_up = helper.make_node('Sum', [A + '_mul_' + B + str(i) + '_' + str(j) + '_' + str(k - 1), cur_result], [A + '_mul_' + B + str(i) + '_' + str(j) + '_' + str(k)])
                    new_nodes.append(add_up)
                elif k == (A_col_count - 1):
                    add_up = helper.make_node('Sum', [A + '_mul_' + B + str(i) + '_' + str(j) + '_' + str(k - 1), cur_result], [result])
                    new_nodes.append(add_up)
    # concating
    row_tensors = []
    for i in range(A_row_count):
        row_elements = []
        for j in range(B_col_count):
            result = A + '_mul_' + B + str(i) + '_' + str(j)
            row_elements.append(result)

        row_tensor_name = A + '_mul_' + B + '_row' + str(i)
        concat_row = helper.make_node(
            'Concat',
            inputs=row_elements,
            outputs=[row_tensor_name],
            axis=1
        )
        row_tensors.append(row_tensor_name)
        new_nodes.append(concat_row)

    concat_full_matrix = helper.make_node(
        'Concat',
        inputs=row_tensors,
        outputs=[output[0] + '_padded'],
        axis=0  # Concatenating along rows
    )
    new_nodes.append(concat_full_matrix)
    # 還原padding
    starts = [0, 0]
    ends = [original_dim_x, original_dim_y]
    axes = [0, 1]

    starts_tensor = helper.make_tensor(
        name=output[0] + '_starts',
        data_type=TensorProto.INT64,
        dims=[len(starts)],
        vals=starts
    )

    ends_tensor = helper.make_tensor(
        name=output[0] + '_ends',
        data_type=TensorProto.INT64,
        dims=[len(ends)],
        vals=ends
    )

    axes_tensor = helper.make_tensor(
        name=output[0] + '_axes',
        data_type=TensorProto.INT64,
        dims=[len(axes)],
        vals=axes
    )
    new_tensors.extend([starts_tensor, ends_tensor, axes_tensor])
    slice_node = helper.make_node(
    'Slice',
        inputs=[
            output[0] + '_padded', 
            output[0] + '_starts', 
            output[0] + '_ends', 
            output[0] + '_axes'],
        outputs=[output[0] + 'original']
    )
    new_nodes.append(slice_node)
    # add bias
    final_result = helper.make_node('Add', [output[0] + 'original', bias], [output[0]])
    new_nodes.append(final_result)

def pad_and_Split_Proto(input_name, shape_str):
    current_nodes = []
    dim_x = shape_str[0]
    dim_y = shape_str[1]
    # 計算要padding到多少
    if dim_x % 64 == 0:
        pad_x = 0
    else:
        pad_x = (64 - (dim_x % 64))

    if dim_y % 64 == 0:
        pad_y = 0
    else:
        pad_y = (64 - (dim_y % 64))
    new_dim_x = dim_x + pad_x
    new_dim_y = dim_y + pad_y
    # padding
    print(f'new_dim_x = {new_dim_x}, new_dim_y = {new_dim_y}')
    pads_data = [0, 0, pad_x, pad_y]
    pads_tensor = helper.make_tensor(
        name = input_name + '_pads_tensor',
        data_type = TensorProto.INT64,
        dims=[len(pads_data)],
        vals=pads_data
    )
    new_tensors.append(pads_tensor)

    pad_node = helper.make_node(
        'Pad',
        inputs=[input_name, input_name + '_pads_tensor'],
        outputs=[input_name + "_padded"],
        mode='constant'
    )
    new_nodes.append(pad_node)

    # splitting, 在這之後for input_name = 'A', 
    # the submatrix in the upper left corner will be named to `A0_0', 
    # and the padded matrix may be the following format:
    # [ A0_0, A0_1, ....., A0_new_dim_y / 64
    #   ..
    #         ...
    #                ...
    #                      Anew_dim_x / 64_new_dim_y / 64]
    split_node_vertical = helper.make_node(
        'Split',
        inputs=[input_name + "_padded"],
        outputs=[f"{input_name}{i}_row" for i in range(int(new_dim_x / 64))],
        axis=0,
        split=[64] * int(new_dim_x / 64)
    )
    new_nodes.append(split_node_vertical)
    for i in range(int(new_dim_x / 64)):
        split_node_horizontal = helper.make_node(
            'Split',
            inputs=[f"{input_name}{i}_row"],
            outputs=[f"{input_name}{i}_{j}" for j in range(int(new_dim_y / 64))],
            axis=1,
            split=[64] * int(new_dim_y / 64)
        )
        new_nodes.append(split_node_horizontal)
    for j in range(int(new_dim_y / 64)):
        print(f"{input_name}{i}{j}")
    print(f'new_dim_x / 64 = {new_dim_x / 64}, new_dim_y / 64 = {new_dim_y / 64}')
    return (int(new_dim_x / 64)), (int(new_dim_y / 64))
# 在這裡首先traverse所有的node，然後去把linear layer抓出來做處理
# 接著把attribute抓出來做處理，然後從inferred_model裡面
# 把該linear layer的input抓出來並沿用tutorial所附的
# `_parse_element` function來取出需要的name以及shape，
# 並做padding, split的操作(會在`pad_and_Split_Proto`那邊做說明)，
# 接著traverse through graph的initializer取出weight和bias，
# 並將weight一樣做padding, split的處理(如果transB == 1要多做transpose)，
# 最後將input, weight, bias的name, output的name, 
# A_row_count, A_col_count, B_col_count, 
# input的dim_x, weight的dim_y傳入`do_64x64_operation`
# 其中A_row_count, A_col_count, B_col_count這三個variable所代表的含義即為
# A是(A_row_count x 64) x (A_col_count x 64)的matrix，
# 因為矩陣乘法要以64x64的submatrix為單位，
# 而因為B_row_count和A_col_count相等，所以只需要傳入B_col_count
# 最後原本input的dim_x, weight的dim_y是用來做還原padding的操作。
for node in graph3.node:
    if 'linear' in node.doc_string:
        # print(node)
        alpha = 0.0
        beta = 0.0
        transB = 0
        for attribute in node.attribute:
            if attribute.name == "alpha":
                alpha = attribute.f
            elif attribute.name == "beta":
                beta = attribute.f
            elif attribute.name == "transB":
                transB = attribute.i
        for value_info in inferred_model.graph.value_info:
            # input
            if value_info.name in node.input:
                # print(f'value_info.name = {value_info.name}')
                name, dtype, shape_str = _parse_element(value_info)
                original_dim_x = shape_str[0]
                A_row_count, A_col_count = pad_and_Split_Proto(name, shape_str)
                A = name
        for initializer in graph3.initializer:
            if initializer.name in node.input:
                # print(f'initializer.name = {initializer.name}')
                # split_TensorProto(initializer, transB)
                dim_x = initializer.dims[0]
                dim_y = 1
                B = initializer.name
                if len(initializer.dims) > 1:
                    dim_y = initializer.dims[1]
                    if transB:
                        transpose_node = helper.make_node(
                            'Transpose',
                            [initializer.name],
                            [initializer.name + '_T'],
                            perm=[1, 0]
                        )
                        new_nodes.append(transpose_node)
                        print(f'transposed_name = {initializer.name}_T')
                        tmp = dim_x
                        dim_x = dim_y
                        dim_y = tmp
                        B = initializer.name  + '_T'
                        original_dim_y = dim_y
                        B_row_count, B_col_count = pad_and_Split_Proto(initializer.name + '_T', [dim_x, dim_y])
                    do_64x64_operation(A, B, node.input[2], node.output, A_row_count, A_col_count, B_col_count, original_dim_x, original_dim_y)
    else:
        new_nodes.append(node)
new_tensors.extend(graph3.initializer)
graph4 = helper.make_graph(new_nodes,
                        'lr3',  # a name
                        graph3.input,
                        graph3.output,
                        new_tensors)  # outputs
opset_version = 11
onnx_model4 = helper.make_model(graph4, opset_imports=[helper.make_opsetid("", opset_version)])

try:
    onnx.checker.check_model(onnx_model4)
except Exception as e:
    print("Model checking failed:", e)
onnx.save(onnx_model4, 'hw2-3-3_graph.onnx')

```

#### Visualize the transformed model graph
因為64x64的要開太久了，所以改成切640x640的submatrix來做圖
- ![](https://course.playlab.tw/md/uploads/786e462e-5570-4b0e-91c5-523e5d612569.png) | ![](https://course.playlab.tw/md/uploads/446137c0-1531-47a5-9a6f-300d8717721a.png)
    ---|---
左圖(對linear layer的input做padding, spliting)
右圖(對weight進行transpose後做padding, spliting)
![](https://course.playlab.tw/md/uploads/46c28bed-4570-41fe-936c-04c2bffa83a1.png)
上圖(input和weight做完sub-matrix multiplication之後進行concat然後還原padding之後再加上bias)

### 2-3-4. Correctness Verification
#### Code
```python=
import onnxruntime as ort
import numpy as np
# 在這裡load model和run完inference之後使用`np.allclose`, 
# 並設置物茶不得超過1e-6
def load_model_and_run_inference(model, inputs):
    session = ort.InferenceSession(model)
    input_name = session.get_inputs()[0].name
    output_name = session.get_outputs()[0].name
    result = session.run([output_name], {input_name: inputs})
    return result[0]

A_input = np.random.rand(10, 3, 224, 224).astype(np.float32)

output_model1 = load_model_and_run_inference('hw2-3-3_graph.onnx', A_input)
output_model2 = load_model_and_run_inference('alexnet.onnx', A_input)

if np.allclose(output_model1, output_model2, atol=1e-6):
    print("Pass!")
else:
    print("Fail!")

```

#### Execution Result
![](https://course.playlab.tw/md/uploads/6d416a2a-b5fb-4a05-86a2-8a4f9ccce717.png)




## HW 2-4 Using Pytorch C++ API to do model analysis on the transformed model graph

### 2-4-1. Calculate memory requirements for storing the model weights.

#### Code
```cpp=
// traverse through the parameter list and calcualte the \
// memory requirements when the name of parameter contains "weight"
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
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/85b4f831-b74c-4e7e-bbcd-afd5a29f66d3.png)



### 2-4-2. Calculate memory requirements for storing the activations

#### Code
```cpp=
// forward the input to traverse the model and calculate the 
// memory requirements for activations by the output tensor's size
int forwarding = 0;
torch::Tensor
run_model_recursively(torch::jit::script::Module module, torch::Tensor input){
    torch::Tensor output = input;
    for (auto submodule : module.named_modules()) {
        if(submodule.name != "" && \
           submodule.name != "features" && submodule.name != "classifier"){
            output = run_model_recursively(submodule.value, output);
            // calculate total_activation_size by the output tensor size
            total_activation_size += (output.numel() * output.element_size());
            // flatten the input to meet the expected input shape
            if(submodule.name == "classifier.0"){
                output = output.view({output.size(0), -1});
            }
            if (submodule.name.find("classifier.") != std::string::npos){
                classifier_count--;
            }
            // when all the classifier have already been traversed, break
            if(!classifier_count){
                break;
            }
        }
    }
    if (classifier_count) {
        output = module.forward({output}).toTensor();
        forwarding++;
    }
    return output;
}

std::vector<at::Tensor> activations;
int main(int argc, const char* argv[]) {
    if (argc != 2) {
    std::cerr << "usage: example-app <path-to-exported-script-module>\n";
    return -1;
    }


    torch::jit::script::Module module;
    try {
    // Deserialize the ScriptModule from a file using torch::jit::load().
    module = torch::jit::load(argv[1]);
    // module.eval();
    }
    catch (const c10::Error& e) {
    std::cerr << "error loading the model\n";
    return -1;
    }

    std::cout << "load the torchscript model, " + std::string(argv[1]) + ", successfully \n";
    module.train();
    std::vector<at::Tensor> activations;
    torch::Tensor input = torch::randn({1, 3, 224, 224});
    for (const auto& submodule : module.named_modules()) {
        if (submodule.name.find("classifier.") != std::string::npos) {
            classifier_count++;
        }
    }
    run_model_recursively(module, input);
    std::cout << "Total memory requirements for storing the activations: " \
        << total_activation_size << " bytes" << std::endl;

    return 0;

}

```

#### Execution Result
![](https://course.playlab.tw/md/uploads/8d6f4c2f-af2f-4811-b0f0-240edb5db7cd.png)


### 2-4-3. Calculate computation requirements

#### Code
```cpp=
// in 2-4-3, I revised the 'run_model_recursively' 
// that is used to calculate memory requirements 
// for storing the activations, can calculate it 
// with MACs here
torch::Tensor run_model_recursively(torch::jit::script::Module module, torch::Tensor input){
    torch::Tensor output = input;
    for (auto submodule : module.named_modules()) {
        if(submodule.name != "" && \
           submodule.name != "features" && submodule.name != "classifier"){
            output = run_model_recursively(submodule.value, output);
            total_activation_size += (output.numel() * output.element_size());
            // flatten
            if(submodule.name == "classifier.0"){
                output = output.view({output.size(0), -1});
            }
            if (submodule.name.find("classifier.") != std::string::npos){
                classifier_count--;
            }
            // when the layer is convolution layer, calculate the MACs based on the equation
            if(submodule.value.type()->str().find("torch.nn.modules.conv") != std::string::npos){
                //  Number of Operations=   Output Height × Output Width × \
                                            Kernel Height × Kernel Width × \
                                            Input Channels × Output Channels
                int output_channels = output.size(1);
                int output_height = output.size(2);
                int output_width = output.size(3);
                int input_channels = last.size(1);
// 這裡的kernel_height, kernel_weight我是直接寫死的，我覺得可能是因為我電腦gen出來的pt檔有問題
// (也有測過原始的alexnet)，所以才會抓不到kernel size(或者有其他方式可以抓只是我沒有找到)。
// 因為有聽到同學成功用layer.attr("kernel_size")抓到kernel size，
// 並且在pytorch source code的attribute map也有列出conv2d layer可以取得weight, bias, stride, kernel_size, padding ...，
// 但我只取得到weight, bias
// 但是無論是在原始的alexnet還是我自己transform過的，
// 無論是在哪一層convolution layer都抓不到weight, bias以外的。
// 如果是在正常的情況之下可以把下面的code替換成
// int kernel_height = submodule.value.attr("kernel_size").toTuple()->elements()[0].toInt()
// int kernel_width = submodule.value.attr("kernel_size").toTuple()->elements()[1].toInt() 
                
                int kernel_height = 1;
                int kernel_width = 1;
                MACs += (output_height * output_width * \
                         kernel_height * kernel_width * \
                         input_channels * output_channels);
            }
    // linear layer, MACs = input_features * output_features
            else if(submodule.value.type()->str().find("CustomLinear") != std::string::npos){
                auto weight_tensor = submodule.value.attr("weight").toTensor();
                int input_features = weight_tensor.size(1);
                int output_features = weight_tensor.size(0);
                MACs += (input_features * output_features);
            }
            if(!classifier_count){
                break;
            }
        }
    }
    if (classifier_count) {
        last = output;
        output = module.forward({output}).toTensor();
        forwarding++;
    }
    return output;
}
```

#### Execution Result
![](https://course.playlab.tw/md/uploads/321a6627-6a62-4d26-9e80-9e21d82e0cf8.png)



### 2-4-4. Compare your results to the result in HW2-1 and HW2-2

#### Discussion
在下面我會貼出用HW2-1, 2-1的實作去算hw2-4所需要計算的efficiency metrics
- Calculate memory requirements for storing the model weights.
    ![](https://course.playlab.tw/md/uploads/56ed55f6-c7a1-425c-b76c-918a660d904c.png)
    在HW2-4-1當中，我所計算出來的結果一樣是244361984，所以應該是前後一致的。
- Calculate memory requirements for storing the activations
    ![](https://course.playlab.tw/md/uploads/03332b14-3458-4ae6-a781-510c31b41817.png)
    在HW2-4-2當中，我所計算出來的結果是4392864，大概差距了五萬多，我覺得有可能是因為我把maxpool的那些layer也算進來了所以才會有這樣的差異，而要解決這個部分可以透過check `submodule.value.type()->str()`然後設定條件去決定要採取哪些layer的output來解決。
- Calculate computation requirements
    ![](https://course.playlab.tw/md/uploads/aa22d064-63d3-4852-9130-fab80763f947.png)
    在HW2-4-3當中，我所計算出來的結果是108309696，而會造成這樣的差異是因為我取不到weight, bias以外的attribute所以直接把kernel_weight, kernel_height設成1，而相關的解決方案我在處理那部分的註解有提到所以就不贅述了。



