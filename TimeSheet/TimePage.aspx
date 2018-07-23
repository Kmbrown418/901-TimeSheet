<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimePage.aspx.cs" Inherits="TimeSheet.TimePage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Time Sheet</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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

    .Hide {
        display:none;
    }
    .modalBackground
  {
	  background-color: #C0C0C0;
	  filter: alpha(opacity=70);
	  opacity: 0.7;
  }
.modalPopup
  {
	background-color: #FFFFFF;
	border-width: 3px;
	border-style: solid;
	border-color: #808080;
	padding: 3px;
	width: 800px;
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

        $(document).on("click", ".open-addTask", function () {

            var myBookId = $(this).data('id');
            $(".modal-body " + "#<%= hfPDID.ClientID %>").val(myBookId);

            document.getElementById("lnkLoadModalData").click();
            $('#mdTask').modal('show');
        });

        $(document).on("click", ".set-addTask", function () {

            $('#mdTask').modal('hide');
            var myBookId = $(this).data('id');
            $(".modal-body " + "#<%= hfPDID.ClientID %>").val(myBookId);

            document.getElementById("lnkSetModalData").click();
            
        });


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
        
                 <div id="Header" style="padding-bottom: 0px; /*text-align: center;*/ height: 103px;" class="container-fluid /*content*/ ">
                        
                    <h1 id="PageName" style="padding-left:10px; color: Black">
                        Plumbing Time Sheet
                    </h1>


                    <div id="HeaderText" style="height:100px;">

                        <script type="text/javascript">
                            function callserver() {
                                $get("btnDate").click();
                            }
                        </script>

                        <div style="width:100% !important; /*text-align: center;*/ float:right;">
                            <p style="display:inline; width:50px; padding-right: 44px;">Date:</p>
		                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" style="width:200px !important; display:inline" OnTextChanged="txtDate_TextChanged" onkeydown="if (event.keyCode == 13){ return false;}" ></asp:TextBox>
		                    <cc1:CalendarExtender ID="ceInteractionDate" runat="server" TargetControlID="txtDate" OnClientDateSelectionChanged="callserver" ></cc1:CalendarExtender>
                        </div>
                    </div>
                  </div>
         <asp:UpdatePanel ID="upPnlUsers" class="Repeat-panel" style="height:100% !important;" runat="server" >
             <ContentTemplate>
                <div style="float:right; padding-right: 20px; position: relative; bottom: 100px;">
                        <asp:HyperLink ID="hlPlumbingReportMonthly" runat="server" style="float:right; position:relative; top:20px" CssClass="blacklink" Text="Plumbing Report Monthly" NavigateUrl="~/Reports/PlumbingReportMonthly.aspx" Target="_blank" />
                        <br /> 
                        <asp:HyperLink ID="hlPlumbingReportDaily" runat="server" style="float:right; position:relative; top:20px" CssClass="blacklink" Text="Plumbing Report Daily" NavigateUrl="~/Reports/PlumbingReportDaily.aspx" Target="_blank" />
                        <br />
                        <asp:HyperLink ID="hlGenerateDailyReport" runat="server" style="float:right; position:relative; top:20px" CssClass="blacklink" Text="Generate Daily Report" NavigateUrl="#" />
                </div>

                 <div id="Header2" style="padding-bottom: 30px; /*text-align: center;*/" class="container-fluid /*content*/ ">
                    <div id="HeaderText2" style="height:140px;">
                        <div id="Plumbers" style="height:65px;">
                            <div style="display:inline; width:60%" >
                                <p style="display:inline; width:50px; padding-right: 22px;">Plumber:</p>
		                        <asp:DropDownList ID="ddlPlumber" runat="server" CssClass="form-control" style="width:200px; height: 30px;display:inline">
                                </asp:DropDownList>
                            </div>
                            <div style="width:100% !important; /*text-align: center;*/">
                            <p style="display:inline; width:85px; padding-right: 0px;">Work Hours:</p>
                            <asp:TextBox ID="txtWorkHours" runat="server" CssClass="form-control" Placeholder="Hours" TextMode="Number" step=".01" style="width:85px !important; display:inline" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                            </div>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator03" runat="server" style="color:black !important" class="form-control btn-danger"
                            ControlToValidate="txtDate" ErrorMessage="Date is required" validationgroup="CreateGroup"
                            SetFocusOnError="True" >
                        </asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator081" runat="server" style="color:black !important" class="form-control btn-danger"
                            ControlToValidate="ddlPlumber" InitialValue="-1" ErrorMessage="Plumber is Required" validationgroup="CreateGroup"
                            SetFocusOnError="True" >
                         </asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator08" runat="server" style="color:black !important" class="form-control btn-danger"
                            ControlToValidate="txtWorkHours" ErrorMessage="Work Hours are required" validationgroup="CreateGroup"
                            SetFocusOnError="True" >
                        </asp:RequiredFieldValidator>

                    </div>
                  </div>

                 <div style="padding-bottom: 30px; /*text-align: center;*/" class="container-fluid /*content*/ ">
                     <div>
                        <div style="display:inline;">
                            <asp:TextBox ID="txtJobNo" runat="server" CssClass="form-control" Placeholder="Job No." TextMode="Number" step="1" onkeydown="if (event.keyCode == 13){ return false;}" style="width:100px !important; display:inline"></asp:TextBox>
                        </div>
                        <div style="display:inline;">
                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" Placeholder="Location" onkeydown="if (event.keyCode == 13){ return false;}" style="max-width:300px; display:inline"></asp:TextBox>
                        </div>

                        <div style="display:inline;">
                             <asp:TextBox ID="txtTotalTime" runat="server" CssClass="form-control" Placeholder="Time" TextMode="Number" step=".01" style="width:75px !important; display:inline" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                        </div>

                        <div style="display:inline;">
		                        <asp:DropDownList ID="ddlCR" runat="server" CssClass="form-control" style="width:200px; display:inline">
                                      <asp:ListItem Selected="True" Value="-1"> --Select Work Type-- </asp:ListItem>
                                      <asp:ListItem Value="Commercial"> Commercial </asp:ListItem>
                                      <asp:ListItem Value="Residential"> Residential </asp:ListItem>
                                        <asp:ListItem Value="Camera Fee"> Camera Fee </asp:ListItem>
                                        <asp:ListItem Value="Leak Detection"> Leak Detection </asp:ListItem>
                                </asp:DropDownList>
                        </div>

                        <div style="display:inline;">
                            <asp:CheckBox ID="chkBillable" CssClass="" runat="server" Text="&nbsp Billable" onkeydown="if (event.keyCode == 13){ return false;}" style= "float:right; top: 8px; position: relative;" AutoPostBack="false" />
                        </div>
                    </div>

                        <asp:Button ID="btnSave" runat="server" type="button" Text="Add" CausesValidation="true" validationgroup="CreateGroup" OnClick="btnSave_Click"/>
 
                     <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator02" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="txtJobNo" ErrorMessage="Job No is required" validationgroup="CreateGroup"
                                SetFocusOnError="True" >
                            </asp:RequiredFieldValidator> 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator04" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="txtLocation" ErrorMessage="Location is required" validationgroup="CreateGroup"
                                SetFocusOnError="True" >
                            </asp:RequiredFieldValidator> 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator05" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="txtTotalTime" ErrorMessage="Total Time is required" validationgroup="CreateGroup"
                                SetFocusOnError="True" >
                            </asp:RequiredFieldValidator> 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" style="color:black !important" class="form-control btn-danger"
                                ControlToValidate="ddlCR" InitialValue="-1" ErrorMessage="Work Type is Required" validationgroup="CreateGroup"
                                SetFocusOnError="True" >
                            </asp:RequiredFieldValidator>
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
                                DataKeyNames="PDID" EmptyDataText="No Hours Entered for This Day" GridLines="None" BorderStyle="None"
                                OnRowDataBound="gvUsers_RowDataBound" OnDataBound="gvUsers_DataBound" OnRowCreated="gvUsers_RowCreated">
                            <Columns>
                                <asp:TemplateField HeaderText="PDID" HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblPDID" runat="server" Text='<%# Eval("PDID")%>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPDID" runat="server" class="Hide" Text='<%# Eval("PDID")%>' />
                                    </EditItemTemplate>
							    </asp:TemplateField>

                                <asp:TemplateField HeaderText="PDID" HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalAll" runat="server" Text='<%# Eval("TotalAll")%>' />
                                    </ItemTemplate>
							    </asp:TemplateField>

                                <asp:TemplateField HeaderText="PDID" HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalBilled" runat="server" Text='<%# Eval("TotalBilled")%>' />
                                    </ItemTemplate>
							    </asp:TemplateField>

                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlTask" runat="server" class="open-addTask" data-toggle="modal" data-target="#mdTask" data-id='<%# Eval("PDID") %>' Text="Edit" NavigateUrl="#"></asp:HyperLink>
                                        <asp:Label ID="lblWorkDate" runat="server" Text='<%# Eval("WorkDate")%>' CssClass="Hide" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div style="display: inline; Float:left">
                                            <asp:LinkButton ID="UpdateButton"
                                                            runat="server"
                                                            CssClass="UpdateButton"
                                                            CommandName="Save"
                                                            Text="Update"
                                                            CausesValidation="true"
                                                            validationgroup="EditGroup"/>
                                            <br />
                                            <asp:LinkButton ID="Cancel"
                                                            runat="server"
                                                            CssClass="CancelButton"
                                                            CommandName="Cancel"
                                                            Text="Cancel" 
                                                            CausesValidation="false"/>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtDateEdit" runat="server" Text='<%#Eval("WorkDate","{0:d}")%>' CssClass="form-control" style="width:200px !important; float:right; display: inline; margin-left: 10px;" onkeydown="if (event.keyCode == 13){ return false;}" ></asp:TextBox>
		                                    <cc1:CalendarExtender ID="ceInteractionDate" runat="server" TargetControlID="txtDateEdit" ></cc1:CalendarExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator033" runat="server" style="width:200px; float:right; color:black !important" class="form-control btn-danger"
                                                ControlToValidate="txtDateEdit" ErrorMessage="Required" validationgroup="EditGroup"
                                                SetFocusOnError="True" >
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Job No">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:Label ID="lblJobID" runat="server" Text='<%# Eval("JobNo")%>' />
                                    </ItemTemplate>
									<EditItemTemplate>
                                        <asp:TextBox ID="txtJobNoEdit" runat="server"  Text='<%# Eval("JobNo")%>' CssClass="form-control" Placeholder="Job No." TextMode="Number" step="1" onkeydown="if (event.keyCode == 13){ return false;}" style="width:100px !important; display:inline"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator02" runat="server" style="color:black !important" class="form-control btn-danger"
                                            ControlToValidate="txtJobNoEdit" ErrorMessage="Required" validationgroup="EditGroup"
                                            SetFocusOnError="True" >
                                        </asp:RequiredFieldValidator> 
                                    </EditItemTemplate>
								</asp:TemplateField>                               

                                <asp:TemplateField HeaderText="Full Name">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:Label ID="lblPlumberID" runat="server" Text='<%# Eval("PlumberID")%>' style="display:none" />
                                        <asp:Label ID="lblFullName" runat="server" Text='<%# Eval("PlumberName")%>' />
                                    </ItemTemplate>
									<EditItemTemplate>
                                        <asp:Label ID="lblPlumberEdit" runat="server" Text='<%# Eval("PlumberID")%>' style="display:none" />
		                                <asp:DropDownList ID="ddlPlumberEdit" runat="server" CssClass="form-control" style="height: 30px; font-size: 14px; display:inline">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
								</asp:TemplateField>

                                <asp:TemplateField HeaderText="Location">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:HyperLink ID="lblLocation" runat="server" class="set-addTask" data-id='<%# Eval("PDID") %>' Text='<%#Eval("JobLocation")%>' NavigateUrl="#"></asp:HyperLink>
                                    </ItemTemplate>
									<EditItemTemplate>
                                        <asp:TextBox ID="txtLocationEdit" runat="server" Text='<%#Eval("JobLocation")%>' CssClass="form-control" Placeholder="Location" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator04" runat="server" style="color:black !important" class="form-control btn-danger"
                                            ControlToValidate="txtLocationEdit" ErrorMessage="Required" validationgroup="EditGroup"
                                            SetFocusOnError="True" >
                                        </asp:RequiredFieldValidator> 
                                    </EditItemTemplate>
								</asp:TemplateField>

                                <asp:TemplateField HeaderText="Work Type" ItemStyle-HorizontalAlign="Left">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Left" />
									<ItemTemplate>
                                        <asp:Label ID="lblWorkType" runat="server" Text='<%#Eval("WorkType")%>'/>
                                    </ItemTemplate>
									<EditItemTemplate>
                                        <asp:DropDownList ID="ddlCREdit" runat="server" CssClass="form-control" style="width:200px; height: 30px;display:inline">
                                                <asp:ListItem Selected="True" Value="-1"> --Select Work Type-- </asp:ListItem>
                                                <asp:ListItem Value="Commercial"> Commercial </asp:ListItem>
                                                <asp:ListItem Value="Residential"> Residential </asp:ListItem>
                                                  <asp:ListItem Value="Camera Fee"> Camera Fee </asp:ListItem>
                                                  <asp:ListItem Value="Leak Detection"> Leak Detection </asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" style="color:black !important" class="form-control btn-danger"
                                            ControlToValidate="ddlCREdit" InitialValue="-1" ErrorMessage="Work Type is Required" validationgroup="EditGroup"
                                            SetFocusOnError="True" >
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Work Date"  ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Right" />
									<ItemTemplate >
                                        <asp:Label ID="lblHours" runat="server" Text='<%#Eval("WorkDate","{0:MM/dd/yyyy}")%>' readonly="true"/>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Total Time" ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Right" />
									<ItemTemplate>
                                        <asp:Label ID="lblHours" runat="server" Text='<%#Eval("TotalTime")%>'/>
                                    </ItemTemplate>
									<EditItemTemplate>
                                        <asp:TextBox ID="txtTotalTimeEdit" runat="server" Text='<%#Eval("TotalTime")%>' CssClass="form-control" Placeholder="Total Time" TextMode="Number" step=".01" style="width:125px !important; display:inline" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator05" runat="server" style="color:black !important" class="form-control btn-danger"
                                            ControlToValidate="txtTotalTimeEdit" ErrorMessage="Required" validationgroup="EditGroup"
                                            SetFocusOnError="True" >
                                        </asp:RequiredFieldValidator> 
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Billable" ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle Font-Size ="20px" />
                                    <HeaderStyle HorizontalAlign="Right" />
									<ItemTemplate>
                                        <asp:Label ID="lblBillable" runat="server" Text='<%#ProcessBillable(Eval("Billable").ToString())%>' />
                                    </ItemTemplate>
									<EditItemTemplate>
                                        <asp:CheckBox ID="chkBillableEdit" CssClass="" runat="server" Checked='<%#Eval("Billable")%>' onkeydown="if (event.keyCode == 13){ return false;}" AutoPostBack="false" />
                                    </EditItemTemplate>
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

        <!-- Modal-->
        <div id="mdTask" class="modal fade" role="dialog">
	        <div class="modal-dialog modal-lg">
		        <div class="modal-content">
			        <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        <div class="modal-body">
				        <asp:TextBox runat="server" ID="hfPDID" 
                                     Value="" Style="display:none;" 
                                     AutoPostBack="true" OnTextChanged="PDID_ValueChanged" CausesValidation="False">
                        </asp:TextBox>
                        
                        <asp:UpdatePanel ID="UpdatePanel1" class="Repeat-panel" style="height:100% !important;" runat="server">
                            <ContentTemplate>
                                <asp:LinkButton ID="lnkLoadModalData" style="height: 40px; width:125px; font-size:15px;" CssClass="flatbutton" CausesValidation="false" runat="server" class="Hide" OnClick="PDID_ValueChanged"></asp:LinkButton>
                                <asp:LinkButton ID="lnkSetModalData" style="height: 40px; width:125px; font-size:15px;" CssClass="flatbutton" CausesValidation="false" runat="server" class="Hide" OnClick="lblLocation_Click"></asp:LinkButton>
                                
                         <div>
                                <div style="width:100% !important; /*text-align: center;*/ float:right;">
                                    <p style="display:inline; width:50px; padding-right: 44px;">Date:</p>
		                            <asp:TextBox ID="txtModalDate" runat="server" CssClass="form-control" style="width:200px !important; display:inline" OnTextChanged="txtDate_TextChanged" onkeydown="if (event.keyCode == 13){ return false;}" ></asp:TextBox>
		                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtModalDate" OnClientDateSelectionChanged="callserver" ></cc1:CalendarExtender>
                                </div>
                                <div style="display:inline; width:60%" >
                                    <p style="display:inline; width:50px; padding-right: 22px;">Plumber:</p>
		                            <asp:DropDownList ID="ddlModalPlumber" runat="server" CssClass="form-control" style="width:200px; height: 30px;display:inline">
                                    </asp:DropDownList>
                                </div>
                                <div style="width:100% !important; /*text-align: center;*/ ">
                                    <p style="display:inline; width:50px; padding-right: 0px;">Work Hours:</p>
                                    <asp:TextBox ID="txtModalWorkHours" runat="server" CssClass="form-control" Placeholder="Hours" TextMode="Number" step=".01" style="width:85px !important; display:inline" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                                </div>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" style="color:black !important" class="form-control btn-danger"
                                    ControlToValidate="txtModalDate" ErrorMessage="Date is required" validationgroup="ModalGroup"
                                    SetFocusOnError="True" >
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator110" runat="server" style="color:black !important" class="form-control btn-danger"
                                    ControlToValidate="txtModalWorkHours" ErrorMessage="Work Hours are required" validationgroup="ModalGroup"
                                    SetFocusOnError="True" >
                                </asp:RequiredFieldValidator>
                                <div>
                                    <div style="display:inline;">
                                        <asp:TextBox ID="txtModalJobNo" runat="server" CssClass="form-control" Placeholder="Job No." TextMode="Number" step="1" onkeydown="if (event.keyCode == 13){ return false;}" style="width:100px !important; display:inline"></asp:TextBox>
                                    </div>
                                    <div style="display:inline;">
                                        <asp:TextBox ID="txtModalLocation" runat="server" CssClass="form-control" Placeholder="Location" onkeydown="if (event.keyCode == 13){ return false;}" style="max-width:300px; display:inline"></asp:TextBox>
                                    </div>

                                    <div style="display:inline;">
                                            <asp:TextBox ID="txtModalTime" runat="server" CssClass="form-control" Placeholder="Time" TextMode="Number" step=".01" style="width:75px !important; display:inline" onkeydown="if (event.keyCode == 13){ return false;}"></asp:TextBox>
                                    </div>
                                    <div style="display:inline;">
		                                    <asp:DropDownList ID="ddlModalCR" runat="server" CssClass="form-control" style="width:200px; display:inline">
                                                  <asp:ListItem Selected="True" Value="-1"> --Select Work Type-- </asp:ListItem>
                                                  <asp:ListItem Value="Commercial"> Commercial </asp:ListItem>
                                                  <asp:ListItem Value="Residential"> Residential </asp:ListItem>
                                                  <asp:ListItem Value="Camera Fee"> Camera Fee </asp:ListItem>
                                                  <asp:ListItem Value="Leak Detection"> Leak Detection </asp:ListItem>
                                            </asp:DropDownList>
                                    </div>
                                    <div style="display:inline;">
                                        <asp:CheckBox ID="chkModaBillable" CssClass="" runat="server" Text="&nbsp Billable" onkeydown="if (event.keyCode == 13){ return false;}" style= "float:right; top: 8px; position: relative;" AutoPostBack="false" />
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <asp:Button ID="btnModalDelete" runat="server" type="button" Text="Delete" CausesValidation="false" OnClick="btnModalDelete_Click"/>
                                    <asp:Button ID="btnModalSave" runat="server" type="button" Text="Update" CausesValidation="true" validationgroup="ModalGroup" OnClick="btnModalSave_Click"/>
                                </div>

                                <div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" style="color:black !important" class="form-control btn-danger"
                                        ControlToValidate="txtModalJobNo" ErrorMessage="Job No is required" validationgroup="ModalGroup"
                                        SetFocusOnError="True" >
                                    </asp:RequiredFieldValidator> 
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" style="color:black !important" class="form-control btn-danger"
                                        ControlToValidate="txtModalLocation" ErrorMessage="Location is required" validationgroup="ModalGroup"
                                        SetFocusOnError="True" >
                                    </asp:RequiredFieldValidator> 
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" style="color:black !important" class="form-control btn-danger"
                                        ControlToValidate="txtModalTime" ErrorMessage="Total Time is required" validationgroup="ModalGroup"
                                        SetFocusOnError="True" >
                                    </asp:RequiredFieldValidator> 
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" style="color:black !important" class="form-control btn-danger"
                                        ControlToValidate="ddlModalCR" InitialValue="-1" ErrorMessage="Work Type is Required" validationgroup="ModalGroup"
                                        SetFocusOnError="True" >
                                    </asp:RequiredFieldValidator>
                                </div>
                        </div>
                        </ContentTemplate>
                            <Triggers>
                            </Triggers>
                    </asp:UpdatePanel>
			        </div>
			        <div class="modal-footer">
				        <button type="button" class="btn btn-default"  data-dismiss="modal">Close</button>
			        </div>
		        </div>
	        </div>
        </div>


    </form>
</body>
</html>