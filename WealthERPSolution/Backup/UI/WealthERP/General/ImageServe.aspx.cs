﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WealthERP.General
{
    public partial class ImageServe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Temppath = "";

            if (Request.QueryString["Path"] != null)
                Temppath = Request.QueryString["Path"].ToString();

            Response.ContentType = "image/jpeg"; // for JPEG file
            string physicalFileName = Temppath;
            if (!Temppath.Equals(String.Empty))
               Response.WriteFile(physicalFileName);
        }
    }
}