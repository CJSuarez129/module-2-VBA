Sub Module2():

    Dim ws As Worksheet
   For Each ws In ThisWorkbook.Worksheets
      
  
       
     Dim ticker As String
        
          ' Set the Ticker
          Dim ticker_total As Double
          ticker_total = 0
        
          ' Set summary table
          Dim summary_row As Integer
          summary_row = 2
          
          ' Set headers for summary table
          ws.Range("I1").Value = "Ticker"
          ws.Range("J1").Value = "Yearly Change"
          ws.Range("K1").Value = "Percent Change"
          ws.Range("L1").Value = "Total Stock Volume"
          
          ' Set the number of rows
          Dim row_count As Long
          row_count = ws.Range("A1").End(xlDown).Row
        
          ' setting for loop
          For i = 2 To row_count
        
            ' Check if we are still within the same ticker, if it is not...
            Dim variable_1 As String
            Dim variable_2 As String
            Dim open_price As Double
            Dim close_price As Double
            
            variable_1 = ws.Cells(i + 1, 1).Value
            variable_2 = ws.Cells(i, 1).Value
            
            ' detect the first row
            If i = 2 Then
                ' set open for first ticker in data set
                open_price = ws.Cells(i, 3).Value
            End If
            
            If variable_1 <> variable_2 Then
        
              ' Set the name
              ticker = ws.Cells(i, 1).Value
        
              ' Add to the total
              ticker_total = ticker_total + ws.Cells(i, 7).Value
              
              ' set close price
              close_price = ws.Cells(i, 6).Value
        
              ' Print the Ticker name in the Summary Table
              ws.Range("I" & summary_row).Value = ticker
        
              ' find change
              ws.Range("J" & summary_row).Value = close_price - open_price
              
              ' finding percentage change
              
              If (open_price <> 0) Then
                ws.Range("K" & summary_row).Value = ((close_price - open_price) / open_price)
                ws.Range("K" & summary_row).Style = "Percent"
               ws.Range("K" & summary_row).NumberFormat = "0.00%"
              End If
        
              ' Print the total volume to the summary row
              ws.Range("L" & summary_row).Value = ticker_total
        
              ' add one to summary
              summary_row = summary_row + 1
              
              ' Reset ticker
              ticker_total_ = 0
              
              ' Get first open price for next ticker
              open_price = ws.Cells(i + 1, 3)
        
            ' else statement for same ticker
            Else
        
              ' adding to total
              ticker_total = ticker_total + ws.Cells(i, 7).Value
        
            End If
        
          Next i
          
          'setting conditional formatting
          Dim Format As Range
          Set Format = ws.Range("J2:J" & CStr(summary_row - 1))
          Format.FormatConditions.Delete
          Format.FormatConditions.Add Type:=xlCellValue, Operator:=xlLess, _
            Formula1:="=0"
          Format.FormatConditions(1).Interior.Color = RGB(255, 0, 0)
          Format.FormatConditions.Add Type:=xlCellValue, Operator:=xlGreaterEqual, _
            Formula1:="=0"
          Format.FormatConditions(2).Interior.Color = RGB(0, 255, 0)
          
  ws.Range("P1").Value = "Ticker"
  ws.Range("Q1").Value = "Value"
  ws.Range("O2").Value = "Greatest % Increase"
  ws.Range("O3").Value = "Greatest % Decrease"
  ws.Range("O4").Value = "Greatest Total Volume"

Dim greatest_increase As Double
Dim greatest_decrease As Double
Dim greatest_volume As Double

greatest_increase = 0
greatest_decrease = 0
greatest_volume = 0

For i = 2 To row_count
    If ws.Cells(i, 11).Value > greatest_increase Then
        greatest_increase = ws.Cells(i, 11).Value
        ws.Range("Q2").Value = greatest_increase
        ws.Range("Q2").Style = "Percent"
        ws.Range("Q2").NumberFormat = "0.00%"
        ws.Range("P2").Value = ws.Cells(i, 9).Value
    End If
   Next i
   For i = 2 To row_count
    
    If ws.Cells(i, 11).Value < greatest_decrease Then
        greatest_decrease = ws.Cells(i, 11).Value
        ws.Range("Q3").Value = greatest_decrease
        ws.Range("Q3").Style = "Percent"
        ws.Range("Q3").NumberFormat = "0.00%"
        ws.Range("P3").Value = ws.Cells(i, 9).Value
    End If
    
   Next i
   For i = 2 To row_count
    
    If ws.Cells(i, 12).Value > greatest_volume Then
        greatest_volume = ws.Cells(i, 12).Value
        ws.Range("Q4").Value = greatest_volume
        ws.Range("P4").Value = ws.Cells(i, 9).Value
    End If
  
    Next i

Next ws
