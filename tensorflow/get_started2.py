# https://www.tensorflow.org/get_started/get_started
# tf.train: Gradien Descent

import tensorflow as tf

# Parameters for Linear model
W = tf.Variable([.3], dtype=tf.float32)
b = tf.Variable([-.3], dtype=tf.float32)
x = tf.placeholder(tf.float32)

# An operation for Linear model
linear_model = W*x + b

# Expeceted values
y = tf.placeholder(tf.float32)

# Loss between our model and expected value
loss = tf.reduce_sum(tf.square(linear_model - y))

# Gradient Descent Optimizer
optimizer = tf.train.GradientDescentOptimizer(0.01)
train = optimizer.minimize(loss)

sess = tf.Session()

# Initialize variables
init = tf.global_variables_initializer()
sess.run(init)

# training data
x_train = [1, 2, 3, 4]
y_train = [0, -1, -2, -3]

for i in range(1000):
    _, curr_W, curr_b, curr_loss = \
        sess.run([train, W, b, loss], {x: x_train, y: y_train})
    print("[%s] W: %s, b: %s, loss: %s" % (i, curr_W, curr_b, curr_loss))
