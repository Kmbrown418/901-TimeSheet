<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlumbingReportMonthly.aspx.cs" Inherits="TimeSheet.Reports.PlumbingReportMonthly" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>901 Plumbing Performance Report</title>
    <link rel="stylesheet" type="text/css" href="print.css" />
</head>
<body>
    <style>
        .ColBlank{
            background-color:transparent !important;
        }

        .ColHeader{
            border-left:solid 3px !important;
            border-right:solid 3px !important;
            border-top:solid 3px !important;
        }

        .ColActual{
            border-left:solid 3px !important;
        }

        .ColDiff{
            border-right:solid 3px !important;
        }

        .ColFooterActual{
            border-top:solid 1px !important;
            border-left:solid 3px !important;
            border-bottom:solid 3px !important;
        }

        .ColFooterDiff{
            border-top:solid 1px !important;
            border-right:solid 3px !important;
            border-bottom:solid 3px !important;
        }

        .ColFooterAll{
            border-top:solid 1px !important;
        }
    </style>

    <form id="form1" runat="server">
    <div style="text-align:center;padding-right: 10px;">
        <h2>901 Plumbing Monthly Performance Report</h2>
    </div>

    <div style="text-align:right;padding-right: 10px;">
        <a href="javascript: window.print()"><asp:Image ID="imgPrint" runat="server" ImageUrl="~/images/printpage.jpg" AlternateText="Print" Height="15" Width="15" /></a>
        <asp:ImageButton ID="btnExportExcel" runat="server" ImageUrl="~/images/excel2.jpg" AlternateText="Excel" BorderStyle="None" Height="15" Width="15" />
    </div>
    <div>
    <asp:GridView ID="gvReport" runat="server" CssClass="reportgrid" AutoGenerateColumns="true" AllowSorting="false" AllowPaging="false" ShowFooter="true"
            FooterStyle-HorizontalAlign="Left" EmptyDataText="The report did not generate any results" AlternatingRowStyle-BackColor="#D2EDF4"
            OnRowCreated="gvReport_RowCreated" OnDataBound="gvReport_DataBound" OnRowDataBound="gvReport_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ReportDate" HeaderText="Month" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:MM/dd/yyyy}" />
            <asp:BoundField DataField="WorkingDays" HeaderText="Days" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField DataField="BillingGoal" HeaderText="Goal" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="MATAllowance" HeaderText="MAT Allowance" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
        </Columns>
    </asp:GridView>
    </div>
    </form>
</body>
</html>

