using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using System.Configuration;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace TimeSheet
{
    public class Time
    {
        private static string GetConnected
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["DBConnect"].ConnectionString;
            }
        }

        public static DataSet getTimeSheet(string Date)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[1];

                parms[0] = new SqlParameter("dateStart", Date);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "getTimeSheet", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("getTimeSheet", ex);
            }
        }

        public static DataSet getPlumbingDaily(string Date)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[1];

                parms[0] = new SqlParameter("dateStart", Date);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "getPlumbingDaily", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("getPlumbingDaily", ex);
            }
        }

        public static DataSet getPlumbingDailyByLocation(string Location)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[1];

                parms[0] = new SqlParameter("location", Location);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "getPlumbingDailyByLocation", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("getPlumbingDailyByLocation", ex);
            }
        }

        public static DataSet getPlumbingDailyByPDID(int PDID)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[1];

                parms[0] = new SqlParameter("PDID", PDID);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "getPlumbingDailyByPDID", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("getPlumbingDailyByPDID", ex);
            }
        }

        public static DataSet DeletePlumbingDaily(int PDID)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[1];

                parms[0] = new SqlParameter("PDID", PDID);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "DeletePlumbingDaily", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("DeletePlumbingDaily", ex);
            }
        }

        public static DataSet tsAddTime(string StaffName, string Date, Decimal StaffHours, string Notes, string EnteredBy, Decimal BilledHours)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[6];

                parms[0] = new SqlParameter("StaffName", StaffName);
                parms[1] = new SqlParameter("WorkDate", Date);
                parms[2] = new SqlParameter("StaffHours", StaffHours);
                parms[3] = new SqlParameter("Notes", Notes);
                parms[4] = new SqlParameter("EnteredBy", EnteredBy);
                parms[5] = new SqlParameter("BilledHours", BilledHours);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "tsAddTime", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("tsAddTime", ex);
            }
        }

        public static DataSet AddPlumbingDaily(string Username, string WorkDate, int PlumberID, Decimal WorkHours, int JobNo, string JobLocation, Decimal TotalTime, bool Billable, string WorkType)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[9];

                parms[0] = new SqlParameter("Username", Username);
                parms[1] = new SqlParameter("WorkDate", WorkDate);
                parms[2] = new SqlParameter("PlumberID", PlumberID);
                parms[3] = new SqlParameter("WorkHours", WorkHours);
                parms[4] = new SqlParameter("JobNo", JobNo);
                parms[5] = new SqlParameter("JobLocation", JobLocation);
                parms[6] = new SqlParameter("TotalTime", TotalTime);
                parms[7] = new SqlParameter("Billable", Billable);
                parms[8] = new SqlParameter("WorkType", WorkType);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "AddPlumbingDaily", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("AddPlumbingDaily", ex);
            }
        }

        public static DataSet EditPlumbingDaily(int PDID, string Username, string WorkDate, int PlumberID, Decimal WorkHours, int JobNo, string JobLocation, Decimal TotalTime, bool Billable, string WorkType)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[10];

                parms[0] = new SqlParameter("PDID", PDID);
                parms[1] = new SqlParameter("Username", Username);
                parms[2] = new SqlParameter("WorkDate", WorkDate);
                parms[3] = new SqlParameter("PlumberID", PlumberID);
                parms[4] = new SqlParameter("WorkHours", WorkHours);
                parms[5] = new SqlParameter("JobNo", JobNo);
                parms[6] = new SqlParameter("JobLocation", JobLocation);
                parms[7] = new SqlParameter("TotalTime", TotalTime);
                parms[8] = new SqlParameter("Billable", Billable);
                parms[9] = new SqlParameter("WorkType", WorkType);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "EditPlumbingDaily", parms);

            }
            catch (Exception ex)
            {
                throw new ApplicationException("EditPlumbingDaily", ex);
            }
        }

        public static DataSet GetAllPlumbers()
        {
            try
            {
                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "GetAllPlumbers");

            }
            catch (Exception ex)
            {
                throw new ApplicationException("GetAllPlumbers", ex);
            }
        }

        public static DataSet MonthlyDailyPlumberReports(string Date)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[1];

                parms[0] = new SqlParameter("Date", Date);

                return SqlHelper.ExecuteDataset(GetConnected, CommandType.StoredProcedure, "MonthlyDailyPlumberReports", parms);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("MonthlyDailyPlumberReports", ex);
            }
        }
    }
}