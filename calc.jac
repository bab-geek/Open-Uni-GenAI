walker init:
    std.out("Welcome to Jaclang Calculator!");
    std.out("Available operations: +, -, *, /");
    std.out("Type 'quit' to exit\n");
    
    here.calc_result = 0;
    
    spawn here walker run_calculator;


walker run_calculator {
    with entry {
        while (true) {
            std.out("Enter first number:");
            input1 = std.input();
            
            if (input1 == "quit") {
                std.out("Goodbye!");
                disengage;
            }
            
            // Convert input to float
            num1 = std.str_to_float(input1);
            if (num1 == null) {
                std.out("Invalid number! Try again.");
                continue;
            }
            
            std.out("Enter operation (+, -, *, /):");
            op = std.input();
            
            if (op == "quit") {
                std.out("Goodbye!");
                disengage;
            }
            
            if (op != "+" and op != "-" and op != "*" and op != "/") {
                std.out("Invalid operation! Use +, -, *, or /");
                continue;
            }
            
            std.out("Enter second number:");
            input2 = std.input();
            
            if (input2 == "quit") {
                std.out("Goodbye!");
                disengage;
            }
            
            num2 = std.str_to_float(input2);
            if (num2 == null) {
                std.out("Invalid number! Try again.");
                continue;
            }
            
            // Perform calculation
            result = here.perform_calculation(num1, num2, op);
            std.out("Result: ", num1, " ", op, " ", num2, " = ", result, "\n");
        }
    }
}

node calculator {
    has calc_result;
    
    can perform_calculation with calc_entry {
        num1 = visitor.num1;
        num2 = visitor.num2;
        operation = visitor.op;
        
        if (operation == "+") {
            result = num1 + num2;
        }
        elif (operation == "-") {
            result = num1 - num2;
        }
        elif (operation == "*") {
            result = num1 * num2;
        }
        elif (operation == "/") {
            if (num2 == 0) {
                std.out("Error: Cannot divide by zero!");
                result = 0;
            } else {
                result = num1 / num2;
            }
        }
        else {
            result = 0;
        }
        
        visitor.result = result;
        ::result;
    }
}