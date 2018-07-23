using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

namespace TimeSheet
{
    public partial class TimePage : System.Web.UI.Page
    {
        decimal qtTotalAll = 0;
        decimal qtTotalBilled = 0;
        int PlumberID = 0;
        int rowIndex = 1;
        string PlumberName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime thisDay = DateTime.Today.AddDays(-1);
                txtDate.Text = thisDay.ToString("d");

                LoadHoursPerStaff();

                bool isMobile = Request.Browser.IsMobileDevice;
                string device = Request.UserAgent;
                if (device.Contains("BlackBerry") || (device.Contains("iPhone") || (device.Contains("Android"))))
                {
                    lblDevice.Text = "Phone Web";
                }
                else
                {
                    lblDevice.Text = "Web";
                }

                if (isMobile)
                {
                    lblDevice.Text = "Mobile " + lblDevice.Text;
                }

                txtWorkHours.Text = "0.0000";

                DataSet ds = new DataSet();
                ds = Time.GetAllPlumbers();
                ddlPlumber.DataSource = ds;
                ddlPlumber.DataTextField = "PlumberName";
                ddlPlumber.DataValueField = "PlumberID";
                ddlPlumber.DataBind();
                ddlPlumber.Items.Insert(0, new ListItem("--Select Plumber--", "-1"));

                ddlModalPlumber.DataSource = ds;
                ddlModalPlumber.DataTextField = "PlumberName";
                ddlModalPlumber.DataValueField = "PlumberID";
                ddlModalPlumber.DataBind();
            }
        }

        public void LoadHoursPerStaff()
        {
            qtTotalAll = 0;
            qtTotalBilled = 0;
            PlumberID = 0;
            rowIndex = 1;
            PlumberName = "";

            DataSet ds = new DataSet();
            ds = Time.getPlumbingDaily(txtDate.Text);

            lblDate.Text = "Showing Time Sheet for Date : " + txtDate.Text;

            gvUsers.DataSource = ds;
            gvUsers.DataBind();
            
        }

        protected void btnDate_Click(object sender, EventArgs e)
        {
            LoadHoursPerStaff();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            ds = Time.AddPlumbingDaily(lblDevice.Text.ToString(), txtDate.Text.ToString(), Int32.Parse(ddlPlumber.SelectedValue.ToString()), Decimal.Parse(txtWorkHours.Text), Int32.Parse(txtJobNo.Text.ToString()), txtLocation.Text.ToString(), Decimal.Parse(txtTotalTime.Text.ToString()), chkBillable.Checked, ddlCR.SelectedValue.ToString());
            LoadHoursPerStaff();

            DateTime thisDay = DateTime.Today.AddDays(-1);
            txtDate.Text = thisDay.ToString("d");
            txtJobNo.Text = "";
            txtLocation.Text = "";
            txtTotalTime.Text = "";
            chkBillable.Checked = false;
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            LoadHoursPerStaff();

            hlPlumbingReportDaily.NavigateUrl = "~/Reports/PlumbingReportDaily.aspx?Date=" + txtDate.Text;
            hlPlumbingReportMonthly.NavigateUrl = "~/Reports/PlumbingReportMonthly.aspx?Date=" + txtDate.Text;
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {

            //gvUsers.EditIndex = e.NewEditIndex;

            //LoadHoursPerStaff();

        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {

            }

            if (e.CommandName == "Edit")
            {

            }

            if (e.CommandName == "Cancel")
            {
                gvUsers.EditIndex = -1;
                LoadHoursPerStaff();
            }

            if (e.CommandName == "Save")
            {
                DataSet ds = new DataSet();

                TextBox txtPDID = (TextBox)gvUsers.Rows[gvUsers.EditIndex].FindControl("txtPDID");
                TextBox txtDateEdit = (TextBox)gvUsers.Rows[gvUsers.EditIndex].FindControl("txtDateEdit");
                TextBox txtJobNoEdit = (TextBox)gvUsers.Rows[gvUsers.EditIndex].FindControl("txtJobNoEdit");
                DropDownList ddlPlumberEdit = (DropDownList)gvUsers.Rows[gvUsers.EditIndex].FindControl("ddlPlumberEdit");
                TextBox txtLocationEdit = (TextBox)gvUsers.Rows[gvUsers.EditIndex].FindControl("txtLocationEdit");
                TextBox txtTotalTimeEdit = (TextBox)gvUsers.Rows[gvUsers.EditIndex].FindControl("txtTotalTimeEdit");
                CheckBox chkBillableEdit = (CheckBox)gvUsers.Rows[gvUsers.EditIndex].FindControl("chkBillableEdit");
                DropDownList ddlWorkType = (DropDownList)gvUsers.Rows[gvUsers.EditIndex].FindControl("ddlCREdit");

                ds = Time.EditPlumbingDaily(Int32.Parse(txtPDID.Text), lblDevice.Text, txtDateEdit.Text, Int32.Parse(ddlPlumberEdit.SelectedValue.ToString()), Decimal.Parse("0.00"), Int32.Parse(txtJobNoEdit.Text), txtLocationEdit.Text, Decimal.Parse(txtTotalTimeEdit.Text), chkBillableEdit.Checked, ddlWorkType.SelectedValue.ToString());
                ds.Clear();

                gvUsers.EditIndex = -1;
                LoadHoursPerStaff();
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gvUsers_RowCreated(object sender, GridViewRowEventArgs e)
        {
            bool newRow = false;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                if ((PlumberID > 0) && (DataBinder.Eval(e.Row.DataItem, "PlumberID") != null))
                {
                    int tests = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PlumberID").ToString());

                    if (PlumberID != tests)
                        newRow = true;
                }

                if ((PlumberID > 0) && (DataBinder.Eval(e.Row.DataItem, "PlumberID") == null))
                {
                    newRow = true;
                    rowIndex = 0;
                }


                if (true) //gvUsers.EditIndex < 0)
                {
                    if (newRow)
                    {
                        AddTotalRow();
                    }
                }
            }
        }

        private void AddTotalRow()
        {
            if (PlumberName.ToString() != "" && qtTotalBilled != 0)
            {
                GridViewRow NewTotalRow = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                NewTotalRow.Font.Bold = true;
                NewTotalRow.BackColor = System.Drawing.ColorTranslator.FromHtml("#008cba");
                NewTotalRow.ForeColor = System.Drawing.Color.White;

                TableCell HeaderCell = new TableCell();
                HeaderCell.Text = "Total for " + PlumberName.ToString();
                HeaderCell.HorizontalAlign = HorizontalAlign.Left;
                HeaderCell.ColumnSpan = 6;
                NewTotalRow.Cells.Add(HeaderCell);

                HeaderCell = new TableCell();
                HeaderCell.HorizontalAlign = HorizontalAlign.Right;
                HeaderCell.Text = String.Format("{0:#0.00}", qtTotalBilled);
                NewTotalRow.Cells.Add(HeaderCell);

                HeaderCell = new TableCell();
                HeaderCell.HorizontalAlign = HorizontalAlign.Right;
                HeaderCell.Text = String.Format("{0:#0.00}", qtTotalAll);
                NewTotalRow.Cells.Add(HeaderCell);

                gvUsers.Controls[0].Controls.Add(NewTotalRow);
                rowIndex++;
                qtTotalBilled = 0;
                qtTotalAll = 0;
            }
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PlumberID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PlumberID").ToString());
                PlumberName = DataBinder.Eval(e.Row.DataItem, "PlumberName").ToString();
                qtTotalBilled = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalAll").ToString());
                qtTotalAll = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalPlumbingDailyBilled").ToString());

                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlPlumberEdit = (DropDownList)e.Row.FindControl("ddlPlumberEdit");
                    Label lblPlumberEdit = (Label)e.Row.FindControl("lblPlumberEdit");

                    DataSet ds = new DataSet();
                    ds = Time.GetAllPlumbers();
                    ddlPlumberEdit.DataSource = ds;
                    ddlPlumberEdit.DataTextField = "PlumberName";
                    ddlPlumberEdit.DataValueField = "PlumberID";
                    ddlPlumberEdit.DataBind();

                    ddlPlumberEdit.SelectedValue = lblPlumberEdit.Text ;
                }
            }
        }

        public string ProcessBillable(string TF)
        {
            if(TF.ToLower() == "True".ToLower() || TF.ToLower() == "T".ToLower())
            {
                return "&#10004";
            }
            else
            {
                return null;
            }
        }

        public bool BillableProcess(string NullNo)
        {
            if (NullNo == null || NullNo == "" || NullNo == "1" || NullNo.ToLower() == "true")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            ds = Time.getPlumbingDailyByPDID(Int32.Parse(hfPDID.Text));

            DateTime yourDate = DateTime.Parse(ds.Tables[0].Rows[0]["WorkDate"].ToString());
            txtModalDate.Text = yourDate.ToString("MM/dd/yyyy");
            ddlModalPlumber.SelectedValue = ds.Tables[0].Rows[0]["PlumberID"].ToString();
            txtModalJobNo.Text = ds.Tables[0].Rows[0]["JobNo"].ToString();
            txtModalLocation.Text = ds.Tables[0].Rows[0]["JobLocation"].ToString();
            txtModalTime.Text = ds.Tables[0].Rows[0]["TotalTime"].ToString();
            chkModaBillable.Checked = BillableProcess(ds.Tables[0].Rows[0]["Billable"].ToString());
            txtModalWorkHours.Text = ds.Tables[0].Rows[0]["TotalWorked"].ToString();
            ddlModalCR.SelectedValue = ds.Tables[0].Rows[0]["WorkType"].ToString();

            LoadHoursPerStaff();
        }

        protected void PDID_ValueChanged(object sender, EventArgs e)
        {
            EditButton_Click(null, null);
        }

        protected void btnModalSave_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();

            ds = Time.EditPlumbingDaily(Int32.Parse(hfPDID.Text), lblDevice.Text, txtModalDate.Text, Int32.Parse(ddlModalPlumber.SelectedValue.ToString()), Decimal.Parse(txtModalWorkHours.Text), Int32.Parse(txtModalJobNo.Text), txtModalLocation.Text, Decimal.Parse(txtModalTime.Text), chkModaBillable.Checked, ddlModalCR.SelectedValue.ToString());
            ds.Clear();

            LoadHoursPerStaff();
        }

        protected void btnModalDelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();

            ds = Time.DeletePlumbingDaily(Int32.Parse(hfPDID.Text));
            ds.Clear();

            LoadHoursPerStaff();
        }

        protected void gvUsers_DataBound(object sender, EventArgs e)
        {
            AddTotalRow();
        }

        protected void lblLocation_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();

            ds = Time.getPlumbingDailyByLocation(txtModalLocation.Text);

            lblDate.Text = "Showing Time Sheet for Location : " + txtModalLocation.Text;

            gvUsers.DataSource = ds;
            gvUsers.DataBind();

        }

        //protected void lbReports_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("PlumbingReportMD.aspx");
        //}
    }
}