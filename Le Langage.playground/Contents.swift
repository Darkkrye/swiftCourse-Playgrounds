//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str += " !"

var a = 5
/*a =*/ a.advanced(by: 7) // Pas que un entier primitif. Besoin de stocker dans la variable sinon il ne modifie pas a
a += 1

var b: Int = a
b += 1

var intArr: [Int] = [1, 2, 5, 9, 10]
intArr.append(89)
intArr.append(2345678)
intArr.remove(at: 4) // Renvoie l'élément supprimé

for e in intArr {
    print(e)
}

var res: Int = 0
for i in 0...intArr.count-1 {
    if intArr[i] > 10 {
        res += 1
    }
}
print(res)

var dict: [Int: String] = [5: "45678", 9: "998765"]
dict[8] = "67890"
print(dict)
print(dict[5]!) // Dangereux si il n'existe pas
if let r = dict[9] { // Plus conseillé
    print(r)
}
print(dict[67])