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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Redirect(Page.ResolveClientUrl("TimePage.aspx"));

            if (!IsPostBack)
            {
                DateTime thisDay = DateTime.Today.AddDays(-1);
                txtDate.Text = thisDay.ToString("d");
                TxtHours.Text = "8.000";
                TxtBilledHours.Text = "0.000";

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

                DataSet ds = new DataSet();
                ds = Time.GetAllPlumbers();
                ddlPlumber.DataSource = ds;
                ddlPlumber.DataTextField = "PlumberName";
                ddlPlumber.DataValueField = "PlumberID";
                ddlPlumber.DataBind();

                ddlPlumber.Items.Insert(0, new ListItem("--Select Plumber--", "-1"));
            }
        }

        public void LoadHoursPerStaff()
        {
            DataSet ds = new DataSet();
            ds = Time.getTimeSheet(txtDate.Text);

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
            ds = Time.tsAddTime(ddlPlumber.SelectedValue.ToString(), txtDate.Text.ToString(), Convert.ToDecimal(TxtHours.Text.ToString()), txtNotes.Text.ToString(), lblDevice.Text, Convert.ToDecimal(TxtBilledHours.Text.ToString()));
            LoadHoursPerStaff();

            DateTime thisDay = DateTime.Today.AddDays(-1);
            txtDate.Text = thisDay.ToString("d");
            TxtHours.Text = "8.000";
            TxtBilledHours.Text = "0.000";
            txtNotes.Text = "";
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            LoadHoursPerStaff();
        }
    }
}