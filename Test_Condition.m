function y = Test_Condition(check_condition)

    define_Node();
    check_condition = Operation_Condition(check_condition);
    check_condition = Fuel_Condition(check_condition);
    y = check_condition;
end