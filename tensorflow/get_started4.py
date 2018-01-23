# https://www.tensorflow.org/get_started/get_started
# tf.estimator: Custom
# high level Tensorflow

import numpy as np
import tensorflow as tf

# Custom model (equivalent to Linear Regression)

def my_model_fn(features, labels, mode):
    W = tf.get_variable("W", [1], dtype=tf.float64)
    b = tf.get_variable("b", [1], dtype=tf.float64)
    y = W*features['x'] + b

    loss = tf.reduce_sum(tf.square(y - labels))

    global_step = tf.train.get_global_step()
    optimizer = tf.train.GradientDescentOptimizer(0.01)
    train = tf.group(optimizer.minimize(loss),
        tf.assign_add(global_step, 1))

    return tf.estimator.EstimatorSpec(
        mode=mode, predictions=y, loss=loss, train_op=train)

# (1) Make estimator
# (1-2) Make estimator: Use my model estimator
estimator = tf.estimator.Estimator(model_fn=my_model_fn)

x_train = np.array([1., 2., 3., 4.])
y_train = np.array([0., -1., -2., -3.])
input_fn = tf.estimator.inputs.numpy_input_fn(
    {"x": x_train}, y_train, batch_size=4, num_epochs=None, shuffle=True)
# (2-2) Train the model
estimator.train(input_fn=input_fn, steps=1000)

# (3) Evalue the model (train data same as train data)
# (3-1) Make the input function
train_input_fn = tf.estimator.inputs.numpy_input_fn(
    {"x": x_train}, y_train, batch_size=4, num_epochs=1000, shuffle=True)
# (3-2) Evalue the model
train_metrics = estimator.evaluate(input_fn=train_input_fn)
print("train_metrics: %r" % train_metrics)

# (3) Evalue the model (eval data)
x_eval = np.array([2., 5., 8., 1.])
y_eval = np.array([-1.01, -4.1, -7, 0.])
eval_input_fn = tf.estimator.inputs.numpy_input_fn(
    {"x": x_eval}, y_eval, batch_size=4, num_epochs=1000, shuffle=False)
eva_metrics = estimator.evaluate(input_fn=eval_input_fn)
print("eval metrics: %r" % eva_metrics)
