using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class admincontact : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindFeedbackData();
                txtSearch.Focus();

            }
        }

        private void BindFeedbackData()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("GetClientProducts", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                conn.Open();
                da.Fill(dt);
                ViewState["dt1"] = dt;

                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }





        protected void btnexport_Click_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/ms-excel";
            Response.AddHeader("content-disposition", "attachment; filename=UserInfo.xls");
            Response.Charset = "";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            GridView1.RenderControl(htw);
            Response.Output.Write(sw.ToString());
            Response.End();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {

        }
        private void SearchData(string keyword)
        {
            using (SqlCommand cmd = new SqlCommand("GetClientGridView", con))
            {
                string searchCriteria = txtSearch.Text.Trim();

                if (!string.IsNullOrEmpty(searchCriteria))
                {
                    DataTable dt = (DataTable)ViewState["dt1"];

                    DataView dv = dt.DefaultView;
                    dv.RowFilter = $"full_name LIKE '%{searchCriteria}%' OR " +
                                   $"email LIKE '%{searchCriteria}%' OR " +
                                   $"CONVERT(Whatsapp_no, 'System.String') LIKE '%{searchCriteria}%' OR " +

                                   $"product_name LIKE '%{searchCriteria}%'";


                    if (dv.Count > 0)
                    {
                        GridView1.DataSource = dv.ToTable();
                        GridView1.DataBind();
                    }
                    else
                    {

                        //lblsmg.Text = "No matching records found for the search criteria.";
                    }
                }

                else
                {

                    BindFeedbackData();
                }
            }

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            SearchData(keyword);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            SearchData(keyword);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rowIndex = e.Row.RowIndex + 1;

                Label lblSerialNumber = e.Row.FindControl("lblSerialNumber") as Label;

                if (lblSerialNumber != null)
                {

                    lblSerialNumber.Text = rowIndex.ToString();
                }
            }
           

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            {
                GridView1.PageIndex = e.NewPageIndex;
                

                BindFeedbackData();
            }
        }

       

    }
}


