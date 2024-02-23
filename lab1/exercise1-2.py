def group_by_students(files):
    ret = { }
    for file, student in files.items():
        if student in ret:
            ret[student].append(file)
        else:
            ret[student] = [file]
    return ret

if __name__ == "__main__":    
    files = {
        'hw1_Mary.txt': 'Mary',
        'hw1_Code_John.py': 'John',
        'hw1_John.txt': 'John',
        'hw2_Mary.txt': 'Mary'
    }   
    print(group_by_students(files))