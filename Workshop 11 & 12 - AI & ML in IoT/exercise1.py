import matplotlib.pyplot as plt

from sklearn import svm, datasets

iris = datasets.load_iris()
print(iris)
irisx = iris.data
print(irisx.shape)
irisy = iris.target
print(irisx.shape)

digits = datasets.load_digits()
print(digits)
digitsx = digits.data
print(digitsx.shape)
digitsy = digits.target
print(digitsy.shape)
plt.gray()
plt.matshow(digits.images[990])
plt.show()
