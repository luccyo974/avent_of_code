import re
class Day1:
    def __init__(self):
        self.lines = open("input.txt",'r').read().split("\n")
        self.calibration_sum = 0

    def first_puzzle(self):
        numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

        for line in self.lines:
            scan_res = [m.group(1) for m in re.finditer(r"(?=(\d|{}))".format("|".join(numbers)), line)]
            digits = self.process_numbers(scan_res)
            calibration_value = int(f"{digits[0]}{digits[-1]}")
            self.calibration_sum += calibration_value

        print(self.calibration_sum)

    def process_numbers(self, digits):
        numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        processed_digits = []

        for d in digits:
            if d in numbers:
                processed_digits.append(numbers.index(d) + 1)
            else:
                processed_digits.append(d)

        return processed_digits


day1 = Day1()
day1.first_puzzle()