#Ref: https://www.youtube.com/watch?v=Y0EF9VqRuEA&feature=youtu.be

import tensorflow as tf
x_train = [1, 2, 3]
y_train = [1, 2, 3]

X = tf.placeholder(tf.float32, shape=[None])
Y = tf.placeholder(tf.float32, shape=[None])
W = tf.Variable(tf.random_normal([1]), name='weight')
H = X * W
cost = tf.reduce_mean(tf.square(H - Y))

learning_rate = 0.1
gradient = tf.reduce_mean((H - Y) * X)

descent = W - learning_rate * gradient
update = W.assign(descent)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(21):
    update_val, cost_val, W_val = \
    sess.run([update, cost, W], feed_dict={X:x_train, Y:y_train})
    print(step, cost_val, W_val)