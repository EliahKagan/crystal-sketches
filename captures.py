#!/usr/bin/env python3

def run():
    actions = []
    for i in range(1, 6):
        actions.append(lambda: print(f'{i} squared is {i**2}.'))

    for f in actions:
        f()

if __name__ == '__main__':
    run()
