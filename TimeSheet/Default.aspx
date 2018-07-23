<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TimeSheet.Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Time Sheet</title>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body style="background-color: rgba(182, 183, 182, .5);">
    <style>
        #maindiv {
        margin: 0px 20%;
    }

    .ColorStyle{
         background-color: white;
         border: solid rgba(232, 0, 17, 1.00) !important;
    }

    .content {
        max-width: 500px;
        margin: auto;
        padding: 10px;
    }
    </style>

    <script>
        $(document).ready(function () {
            $("#form1").submit(function (event) {
                event.preventDefault();
                $.ajax({
                    success: function (response) {
                    }
                })
            });
        })
    </script>

    <form id="form1" runat="server">

        <div class="container-fluid" style="background-color: #fff;padding: 10px;">
            <div style=" display:block; margin:auto; padding-right: 20px; height:100px">
                <img src="http://www.901plumbing.com/files/large_p129_n5.png" height="100px" style="display:block; margin:auto;"/>
            </div>
        </div>
    <div style="height:50px; background-color:rgba(0, 140, 186, 1.00) "></div>
    <div id="maindiv" class="ColorStyle" style="padding-top:0px !important">
        
        <asp:ScriptManager ID="ScriptManager1" runat="server" />


                 <div id="Header" style="padding-bottom: 30px; text-align: center;" class="container-fluid content ">
                    <h1 id="PageName" style="padding-left:10px; color: Black">
                        Plumbing Time Sheet
                    </h1>

                    <div id="HeaderText" style="height:100px;">

                        <script type="text/javascript">
                            function callserver() {
                                $get("btnDate").click();
                            }
                        </script>

                        <div style="width:100% !important;text-align: center; float:right;">
		                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" style="width:60% !important; display:inline" OnTextChanged="txtDate_TextChanged" onkeydown="if (event.keyCode == 13){ return false;}" ></asp:TextBox>
		                    <cc1:CalendarExtender ID="ceInteractionDate" runat="server" TargetControlID="txtDate" OnClientDateSelectionChanged="callserver" ></cc1:CalendarExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator03" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="txtDate" ErrorMessage="Date is required"
                                SetFocusOnError="True" >
                            </asp:RequiredFieldValidator>  
                        </div>
                    </div>
                  </div>

         <asp:UpdatePanel ID="upPnlUsers" class="Repeat-panel" style="height:100% !important;" runat="server" updatemode="Conditional">
             <ContentTemplate>
                 <div style="padding-bottom: 30px; text-align: center;" class="container-fluid content ">
                    <div id="Plumbers" style="height:65px;">
                        <div style="display:inline; width:100%" >
		                    <asp:DropDownList ID="ddlPlumber" runat="server" style="width:100%; height: 30px;">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator01" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="ddlPlumber" ErrorMessage="You must select Plumber"
                                SetFocusOnError="True" InitialValue="-1">
                            </asp:RequiredFieldValidator> 
                        </div>
                    </div>

                     <div>
                        <div style="display:inline; float:left">
                            Hours Worked:         
                        </div>
                        <div style="display:inline;">
                            Hours Billed:
                        </div>
                     </div>

                     <div>
                        <div style="display:inline;">
                            <asp:TextBox ID="TxtHours" runat="server" CssClass="form-control" Placeholder="Hours Worked" TextMode="Number" step="0.01" onkeydown="if (event.keyCode == 13){ return false;}" style="width:50% !important; display:inline"></asp:TextBox>
                        </div>
                        <div style="display:inline;">
                            <asp:TextBox ID="TxtBilledHours" runat="server" CssClass="form-control" Placeholder="Hours Billed" TextMode="Number" step="0.01" onkeydown="if (event.keyCode == 13){ return false;}" style="width:50% !important; float:right"></asp:TextBox>
                        </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator02" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="TxtHours" ErrorMessage="Hours are required"
                                SetFocusOnError="True" >
                            </asp:RequiredFieldValidator> 
                     </div>

                    <div id="Notes" style="height:1300px;display:inline">
                        <div style="width:100% !important;">
                            <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" Placeholder="Notes and Job Information" TextMode="MultiLine" Rows="5" style="display:inline" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                        </div>
                    </div>
                      <div class="modal-footer">
                        <asp:Button ID="btnSave" runat="server" type="button" Text="Save" CausesValidation="true" OnClick="btnSave_Click"/>
                      </div>
                  </div>

                  <div>   
                        <asp:LinkButton ID="btnDate" style="height: 40px; width:125px; font-size:15px;" CssClass="flatbutton" CausesValidation="false" runat="server" OnClick="btnDate_Click">
                            Refresh Time Sheet
                        </asp:LinkButton>
                      <br />
                      <asp:Label ID="lblDate" runat="server"></asp:Label>
                      <br />
                      <asp:Label ID="lblDevice" runat="server" style="display:none"></asp:Label>
                        <asp:GridView ID="gvUsers" runat="server" CssClass="table table-striped table-hover" style="background-color:white" AutoGenerateColumns="false" 
                                DataKeyNames="TSID" EmptyDataText="No Hours Entered for This Day" GridLines="None" BorderStyle="None">
                            <Columns>
                                <asp:TemplateField HeaderText="Full Name">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:Label ID="lblFullName" runat="server" Text='<%# Eval("StaffName")%>' />
                                    </ItemTemplate>
								</asp:TemplateField>

                                <asp:TemplateField HeaderText="Hours Worked">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:Label ID="lblHours" runat="server" Text='<%#Eval("StaffHrs")%>' />
                                    </ItemTemplate>
								</asp:TemplateField>
                                <asp:TemplateField HeaderText="Hours Billed">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:Label ID="lblBilledHours" runat="server" Text='<%#Eval("BilledHrs")%>' />
                                    </ItemTemplate>
								</asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>       
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"/>
                        <asp:AsyncPostBackTrigger ControlID="txtDate" />
                    </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>