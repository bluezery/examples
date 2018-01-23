# https://www.tensorflow.org/get_started/get_started

import tensorflow as tf

# (1) Computational Graph
# (1-1) Buliding computational graph by defining nodes
# Constant type node: no input, constant output
node1 = tf.constant(3.0, dtype=tf.float32)
node2 = tf.constant(4.0)
print("node1 :", node1, ", node2: ", node2)

# (1-2) Running computational graph
sess = tf.Session()
print("####### Run constatants")
print(sess.run([node1, node2]))

# (2) Operations
# Add operations
node3 = tf.add(node1, node2)
print("node3: ", node3)
print("######## Run add operations: ")
print(sess.run(node3))

# (3) Placeholders
a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)
adder_node = a + b  # tf.add(a, b)
print("######### Run placeholder")
print(sess.run(adder_node, {a: 3, b: 4.5}))
print(sess.run(adder_node, {a: [1, 3], b: [2, 4]}))

# (4) Another operations
add_and_triple = adder_node * 3
print("######### Run add + triple operations")
print(sess.run(add_and_triple, {a: 3, b: 4.5}))

# (5) Linear Model
# (5-1) define variables (not init yet)
W = tf.Variable([.3], dtype=tf.float32)
b = tf.Variable([-.3], dtype=tf.float32)
x = tf.placeholder(tf.float32)
linear_model = W*x + b

# (5-2) Initialize all variables (e.g. tf.Variables, etc.)
init = tf.global_variables_initializer()
sess.run(init)

# (5-3) Run the graph
print("######### Run linear model")
print(sess.run(linear_model, {x: [1, 2, 3, 4, 5]}))

# (5-4-1) Measure the model by loss function
# desired values
print("######### Calculate Loss")
y = tf.placeholder(tf.float32)
measure = tf.square(linear_model - y)
loss = tf.reduce_sum(measure)
print(sess.run(loss, {x: [1, 2, 3, 4], y: [0, -1, -2, -3]}))

# (5-4-2) Reassign variables
print("######### fix variables")
fixW = tf.assign(W, [-1.])
fixb = tf.assign(b, [1.])
sess.run([fixW, fixb])
print(sess.run(loss, {x: [1, 2, 3, 4], y: [0, -1, -2, -3]}))
