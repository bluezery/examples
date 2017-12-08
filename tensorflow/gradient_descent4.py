#Ref: https://www.youtube.com/watch?v=Y0EF9VqRuEA&feature=youtu.be
## Compare with Tensorflow built-in GradientDescent

import tensorflow as tf
x_train = [1, 2, 3]
y_train = [1, 2, 3]

X = tf.placeholder(tf.float32, shape=[None])
Y = tf.placeholder(tf.float32, shape=[None])
W = tf.Variable(tf.random_normal([1]), name='weight')

learning_rate = 0.01
gradient = tf.reduce_mean((W * X - Y) * W) * 2
descent = W - learning_rate * gradient
update = W.assign(descent)

XX = tf.placeholder(tf.float32, shape=[None])
YY = tf.placeholder(tf.float32, shape=[None])
WW = tf.Variable(tf.random_normal([1]), name='weight2')
cost = tf.reduce_mean(tf.square(XX * WW - YY))
optimizer = tf.train.GradientDescentOptimizer(learning_rate = learning_rate)
gvs = optimizer.compute_gradients(cost)
apply_gradients = optimizer.apply_gradients(gvs)
#train = optimizer.minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(100):
    update_val, gradient_val, W_val = \
    sess.run([update, gradient, W], feed_dict={X:x_train, Y:y_train})
    apply_gradients_val, WW_val = \
    sess.run([apply_gradients, WW], feed_dict={XX:x_train, YY:y_train})
    print(step, gradient_val, W_val, apply_gradients_val, WW_val)