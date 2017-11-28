
trigger procedure for write of Customer old buffer oldCustomer.


define variable i as integer initial 0.
define variable Outstanding as integer initial 0.

if Customer.Cust-Num <> oldCustomer.Cust-Num and oldCustomer.Cust-Num <> 0
then do:

   for each order of oldCustomer:
      Order.Cust-Num = Customer.Cust-Num.
      i = i + 1.
   end.
   if i > 0 then
     message i "orders changed to reflect the new customer number!" 
	     view-as alert-box information buttons ok.
end.
