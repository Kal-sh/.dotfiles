#! Tip Calculator


def get_input_float(prompt, min_value, max_value):
    while True:
        try:
            value = float(input(prompt))
            if min_value <= value <= max_value:
                return value
            else:
                print(
                    f"Invalid Input, please enter a value between {
                      min_value} and {max_value}"
                )
        except ValueError:
            print("Invalid input, please enter a valid value")


def calculate_total_bill(total_bill, tip):
    return total_bill * (1 + tip / 100)


def calculate_personal_bill(total_bill, num_people):
    return total_bill / num_people


def main():
    print("welcome to the tip calculator.")

    # Get user input
    total_bill = get_input_float("what is the total bill?\n", 1, 1000000)
    num_people = get_input_float("How many people to split the bill?\n", 2, 1000000)
    tip = get_input_float("What percentage tip would you like to give?\n", 0, 100)

    # Calculate the total bill and personal bill
    total_amount = calculate_total_bill(total_bill, tip)
    personal_bill = calculate_personal_bill(total_amount, num_people)

    # Print result
    print(f"Each person should pay: {personal_bill:.2f}$")


if __name__ == "__main__":
    main()
