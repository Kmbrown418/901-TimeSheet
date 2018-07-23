using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;


namespace TimeSheet.Reports
{
    public partial class PlumbingReportDaily : System.Web.UI.Page
    {
        static List<string> NamesInReport = new List<string>();
        static List<decimal> OngoingSums = new List<decimal>();
        int NumberOfColumnsSet = 3;
        int NumberOfHiddenCol = 4;

        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();

            string date = null;
            if (!String.IsNullOrEmpty(Request.QueryString["Date"]))
            {
                date = Request.QueryString["Date"];
            }

            ds = Time.MonthlyDailyPlumberReports(date);

            NamesInReport = new List<string>();
            OngoingSums = new List<decimal>();

            gvReport.DataSource = ds.Tables[1];
            gvReport.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void btnExportExcel_Click(object sender, ImageClickEventArgs e)
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ProfitShare.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            gvReport.AllowPaging = false;

            DataSet ds = new DataSet();

            string date = null;
            if (!String.IsNullOrEmpty(Request.QueryString["Date"]))
            {
                date = Request.QueryString["Date"];
            }

            ds = Time.MonthlyDailyPlumberReports(date);

            gvReport.DataSource = ds.Tables[1];
            gvReport.DataBind();

            //Change the Header Row back to white color
            gvReport.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < gvReport.HeaderRow.Cells.Count; i++)
            {
                gvReport.HeaderRow.Cells[i].Style.Add("background-color", "#29179f");
                gvReport.HeaderRow.Cells[i].Style.Add("color", "#fff");
            }
            gvReport.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        protected void gvReport_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //hides the columns
            for (int i = NumberOfColumnsSet; i < NumberOfColumnsSet + NumberOfHiddenCol; i++)
            {
                e.Row.Cells[i].Visible = false;
            }
        }

        protected void gvReport_DataBound(object sender, EventArgs e)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            TableHeaderCell cell = new TableHeaderCell();
            cell.ColumnSpan = NumberOfColumnsSet;
            cell.HorizontalAlign = HorizontalAlign.Center;
            cell.CssClass = "ColBlank";
            row.Controls.Add(cell);

            if (gvReport.Rows.Count > 0)
            {
                for (int i = NumberOfHiddenCol; i < gvReport.Rows[0].Cells.Count - NumberOfHiddenCol; i = i + 2)
                {
                    cell = new TableHeaderCell();
                    cell.ColumnSpan = 2;
                    cell.HorizontalAlign = HorizontalAlign.Center;
                    cell.Text = NamesInReport[((i - NumberOfHiddenCol) / 2)];
                    cell.CssClass = "ColHeader";
                    row.Controls.Add(cell);
                }
            }

            gvReport.HeaderRow.Parent.Controls.AddAt(0, row);
        }

        protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i < e.Row.Controls.Count; i++)
                {
                    var headerCell = e.Row.Controls[i] as DataControlFieldHeaderCell;
                    if (headerCell != null)
                    {
                        headerCell.Text = headerCell.Text + "~";
                        if (headerCell.Text.Contains("_A~"))
                        {
                            NamesInReport.Add(headerCell.Text.Substring(0, headerCell.Text.Length - 3).Replace('_', ' '));

                            headerCell.Text = "Actual";
                            headerCell.CssClass = "ColActual";
                        }
                        else if (headerCell.Text.Contains("_D~"))
                        {
                            headerCell.Text = "Diff";
                            headerCell.CssClass = "ColDiff";
                        }
                        headerCell.Text = headerCell.Text.Trim('~');
                    }
                }
            }
            else
            {
                for (int i = 0; i < gvReport.HeaderRow.Cells.Count; i++)
                {
                    string HeaderText = gvReport.HeaderRow.Cells[i].Text;
                    var cell = e.Row.Cells[i] as DataControlFieldCell;

                    decimal value = 0;
                    try
                    {
                        value = Decimal.Parse(cell.Text);
                    }
                    catch { }

                    bool error = false;
                    try
                    {
                        OngoingSums[i] = OngoingSums[i] + value;
                    }
                    catch
                    {
                        error = true;
                    }

                    if (error)
                    {
                        OngoingSums.Add(value);
                    }

                    if (i == 1)
                    {
                        cell.Text = CastToInt(cell.Text).ToString();
                    }
                    else if (i >= NumberOfHiddenCol)
                    {
                        cell.Text = CastToNumber(cell.Text).ToString();
                    }

                    if (i >= NumberOfHiddenCol)
                    {
                        e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Right;
                    }

                    if (cell.Text.Substring(0, 1) == "-")
                    {
                        cell.Text = "(" + cell.Text.TrimStart('-') + ")";
                    }

                    if (cell.Text == "0" || cell.Text == "0.00")
                    {
                        cell.Text = "-";
                    }

                    if (HeaderText != null)
                    {
                        if (HeaderText == "Actual")
                        {
                            cell.CssClass = "ColActual";
                        }
                        else if (HeaderText == "Diff")
                        {
                            cell.CssClass = "ColDiff";
                        }
                    }
                }
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                for (int i = 0; i < e.Row.Controls.Count; i++)
                {

                    var footerText = e.Row.Controls[i] as DataControlFieldCell;
                    string HeaderText = gvReport.HeaderRow.Cells[i].Text;
                    footerText.HorizontalAlign = HorizontalAlign.Right;

                    if (HeaderText != null)
                    {
                        if (HeaderText == "Actual")
                        {
                            footerText.CssClass = "ColFooterActual";
                        }
                        else if (HeaderText == "Diff")
                        {
                            footerText.CssClass = "ColFooterDiff";
                        }
                        else
                        {
                            footerText.CssClass = "ColFooterAll";
                        }
                    }


                    if (i != 0 && i != 2 && i != 3)
                    {
                        footerText.Text = OngoingSums[i].ToString();
                        if (i == 1)
                        {
                            footerText.Text = CastToInt(footerText.Text).ToString();
                        }
                        else
                        {
                            footerText.Text = CastToNumber(footerText.Text).ToString();
                        }

                        if (footerText.Text.Substring(0, 1) == "-")
                        {
                            footerText.Text = "(" + footerText.Text.TrimStart('-') + ")";
                        }
                    }
                }
            }
        }

        private static object CastToInt(string ovalue)
        {
            if (string.IsNullOrEmpty(ovalue))
            {
                return DBNull.Value;
            }
            else
            {
                String s = "NaN";
                try
                {
                    s = String.Format("{0:n}", Convert.ToDecimal(ovalue));
                }
                catch { }

                return s.Split('.')[0];
            }
        }

        private static object CastToNumber(string ovalue)
        {
            if (string.IsNullOrEmpty(ovalue))
            {
                return DBNull.Value;
            }
            else
            {
                String s = "NaN";
                try
                {
                    s = String.Format("{0:n}", Convert.ToDecimal(ovalue));
                }
                catch { }

                return s;
            }
        }
    }
}