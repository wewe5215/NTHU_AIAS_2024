def unique_fruit(list1, list2):
    ret = []
    for item in list1:
        if item not in ret:
            ret.append(item)
    for item in list2:
        if item not in ret:
            ret.append(item)
    return ret

if __name__ == "__main__":
    list1 = ["Apple", "Banana", "Orange"]
    list2 = ["Grape", "Apple", "Pineapple", "Orange"]
    print(unique_fruit(list1, list2))