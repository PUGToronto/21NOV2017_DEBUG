
{Report1.I1}

run UpdCust.P.

for each Customer no-lock:
  for first tt-Rpt 
  where tt-Rpt.Cust-Name = Customer.Name:
  end.
  if not avail tt-Rpt then do:
    create tt-Rpt.
    tt-Rpt.Cust-Name = Customer.Name.
  end.
  run CalcTotalOwed(Customer.Cust-Num, output vTotalOwed).
  tt-Rpt.Total-Owed = vTotalOwed.     
end.

vMinOwedLimit = 20000.
for each tt-Rpt:
  
  if tt-Rpt.Total-Owed > vMinOwedLimit then do: 
    vCnt = vCnt + 1.
    displ tt-Rpt.Cust-Name tt-Rpt.Total-Owed.
  end.  
end.
displ vCnt.

procedure CalcTotalOwed:
def input parameter pCust-Num as int no-undo.
def output parameter pTotalOwed as dec no-undo.
  
  def buffer Invoice for Invoice.
  
  for each Invoice no-lock
  where Invoice.Cust-Num = pCust-Num and
  Invoice.Total-Paid < Invoice.Amount:
    pTotalOwed = pTotalOwed + Invoice.Amount - Invoice.Total-Paid.
  end.
end.