#!/usr/bin/env python3

"""Python sketch of the sort of thing forward.cr should do."""

def collect_to_list(supplier):
    results = []
    supplier(results.append)
    return results


def each_day(action):
    action('Sunday')
    action('Monday')
    action('Tuesday')
    action('Wednesday')
    action('Thursday')
    action('Friday')
    action('Saturday')


if __name__ == '__main__':
    days = collect_to_list(each_day)
    days.sort()
    print(days)
