import onnx
from onnx import helper
from onnx import TensorProto
import numpy as np

# 2-3-1. create a subgraph (1) that consist of a single Linear layer of size MxKxN
# input
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

# 2-3-2. create a subgraph (2) as shown in the above diagram for the subgraph (1)
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

# 2-3-3. replace the Linear layers in the AlexNet with the equivalent subgraphs (2)
from google.protobuf.text_format import MessageToString
from onnx import shape_inference
onnx_model3 = onnx.load('alexnet.onnx', load_external_data=False)
graph3 = onnx_model3.graph
new_nodes = [ ]
new_tensors = [ ]
inferred_model = shape_inference.infer_shapes(onnx_model3)
debugging = 1

def do_64x64_operation(A, B, bias, output, A_row_count, A_col_count, B_col_count, original_dim_x, original_dim_y):
    # calculating
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

    # splitting
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
# 2-3-4. Correctness Verification
# Write a script to verify that the transformed AlexNet model is
# mathmatically equivalent to the original Alexnet model.
import onnxruntime as ort
import numpy as np

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
