# Fibonacci And Prime Counter Design

This project is focused on designing a structural digital circuit that counts either prime numbers or Fibonacci numbers based on a given input. The circuit can count in either an upward or downward direction, depending on another input. It is designed to count the first 11 numbers of the selected sequence using T Flip Flops and combinational logic.

## Features
- **Prime and Fibonacci Counting**: The circuit can count the first 11 numbers of the prime or Fibonacci sequence.
- **Upward and Downward Counting**: It can count in both upward and downward directions.
- **T Flip Flop Utilization**: The circuit uses T Flip Flops for the counting mechanism.
- **Test Bench**: A test bench is included to simulate different scenarios and verify the correctness of the design.

## Inputs and Outputs
### Inputs
1. **PorF**: Determines whether to count prime numbers (0) or Fibonacci numbers (1).
2. **UorD**: Determines the counting direction: up (0) or down (1).
3. **Reset**: Asynchronous reset.
4. **Enable**: Synchronous enable.
5. **Clock**: Input clock signal.

### Output
- **6-bit Output**: Represents the current count value.

## Design Details
### T Flip Flop
The T Flip Flop, also known as a toggle flip-flop, changes its state on each clock cycle when the T input is high. For this project, the T Flip Flop is used to store a single bit of information, and the counter requires six T Flip Flops to handle the binary representation of the largest number (55) in the sequences.

### Prime Sequence
The prime numbers counted are: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, and 31.

### Fibonacci Sequence
The Fibonacci numbers counted are: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, and 55.

## Implementation
The implementation involves creating state tables for both prime and Fibonacci sequences, for both upward and downward counting. The state tables are used to determine the next state based on the current state and the input conditions.

### First Design 
![image](https://github.com/user-attachments/assets/a56ef297-45eb-4b75-8cb5-4b5e189e82b9)

### Second Design 
![image](https://github.com/user-attachments/assets/38e78ac4-f596-4b09-9854-1720c0ad03fd)

## 🔗 Links

[![facebook](https://img.shields.io/badge/facebook-0077B5?style=for-the-badge&logo=facebook&logoColor=white)](https://www.facebook.com/qossay.rida?mibextid=2JQ9oc)

[![Whatsapp](https://img.shields.io/badge/Whatsapp-25D366?style=for-the-badge&logo=Whatsapp&logoColor=white)](https://wa.me/+972598592423)

[![linkedin](https://img.shields.io/badge/linkedin-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/qossay-rida-3aa3b81a1?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app )

[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/qossayrida)


