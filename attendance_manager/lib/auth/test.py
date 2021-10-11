# # n = int(input())
# # ls = list(map(int, input().split()))
# # k = int(input())

# # if n<=1:
# #     print(*ls)

# # else:
# #     temp = ls.pop(0)
# #     print(ls)
# #     tempList = ls[k%len(ls):] + ls[:k%len(ls)]

# #     tempList.insert(0, temp)
# #     print(*tempList)

# n = int(input())
# array = list(map(int, input().split()))
# d = int(input())

# temp = array.pop(0)
# array1 = array[-(d%len(array)):] + array[:-(d%len(array))]
# array1.insert(0, temp)

# print(" ".join(map(str, array1)))
# # print(array2)


# # Prefix = [0]

# # def repeated_digit(n):
# #     a = []
# #     while n != 0:
# #         d = n%10
# #         if d in a:
# #             return 0
# #         a.append(d)
# #         n = n//10
# #     return 1
  
# # def pre_calculation(MAX):
# #     global Prefix
# #     Prefix.append(repeated_digit(1))
# #     for i in range(2,MAX+1):
# #         Prefix.append( repeated_digit(i) +
# #                        Prefix[i-1] )
  
# # def calculate(L,R):
# #     return Prefix[R]-Prefix[L-1]

# # MAX = 1000
  
# # pre_calculation(MAX)
  
# # n1 = int(input())
# # n2 = int(input())

# # print(calculate(n1, n2))


# -------------------------------------------

# n = int(input())
# y = int(input())

# times = []
# for _ in range(n):
#     times.append(int(input()))

# index = times.index(max(times))
# index2 = index

# if index == n - 1:
#     index2 = index - 1

# elif times[index+1] > times[index-1]:
#     index2 = index + 1
# else:
#     index2 = index - 1

# totalTime = 0

# for i, value in enumerate(times):
#     if i == index and (index!=0 or index!=n-1) :
#         totalTime += min(value, y)
#     elif i == index2:
#         totalTime += min(value, y)
#     else:
#         totalTime += value

# print(totalTime)

# -------------------------------------------

# for i in times[:2]:
#     totalTime += min([y, i])

# for i in times[2:]:
#     totalTime += i

# n = int(input())
# ls = list(map(int, input().split()))

# res = []

# for i in ar[::-1]:
#     if i not in res:
#         res.append(i)

# print(*res[::-1])
len1 = int(input())
arr1 = []
for _ in range(len1):
    arr1.append(int(input()))

len2 = int(input())
arr2 = []
for _ in range(len2):
    arr2.append(int(input()))

sumArr1 = 0;
sumArr2 = 0;

for i in range(len1):
    sumArr1 += arr1[i]
for j in range(len2):
    sumArr2 += arr2[j]

if (sumArr1 % 2 == 0 and sumArr2 % 2 == 0):
    print(0)

elif (sumArr1 % 2 == 0 and sumArr2 % 2 != 0) or ((sumArr1 % 2 != 0 and sumArr2 % 2 == 0)):
    print(-1)
else:
    count = 0
    for i in arr1:
        for j in arr2:
            if i%2 == 0:
                if j % 2 != 0:
                    count+=1
                    break
            else:
                if j % 2 == 0:
                    count+=1
                    break
    if count >= 1:
        print(1)
    else:
        print(-1)

    # i = 0
    # j = 0
    # count = 0
    # ele = arr2[0]
    # while i<len1:
    #     if ele % 2 == 0:
    #         if arr1[i] % 2 != 0:
    #             count+=1
    #             break
    #     else:
    #         if arr1[i] % 2 == 0:
    #             count+=1
    #             break
    #     i+=1
    # if count == 1:
    #     print(1)
    # else:
    #     print(-1)

# If both sumArr1 and sumArr2
# are odd and check for a pair
# with sum odd sum
# if (sumArr1 % 2 != 0 and sumArr2 % 2 != 0):

#     # Stores if a pair with
#     # odd sum exists or not
#     flag = -1;

#     # Traverse the array
#     for i in range(len1):

#         # If a pair exists with odd
#         # sum, set flag = 1
#         if ((arr1[i] + arr2[i]) % 2 == 1):
#             flag = 1;
#             break;

#     # Print the answer and return
#     print(flag);

# # For all other cases, pr-1
# print(-1);
 
# # Driver code
# if __name__ == '__main__':
#     arr1 = [11, 14, 20, 2];
#     arr2 = [5, 9, 6, 3];
#     N = len(arr1);
 
    # Function Call
    # minimumSwaps(arr1, arr2, N);