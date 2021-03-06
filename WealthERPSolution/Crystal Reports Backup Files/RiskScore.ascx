﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskScore.ascx.cs" Inherits="WealthERP.Research.RiskScore" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.1.min.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".flip").click(function() { $(".panel").slideToggle(); });
    });
</script>

<script type="text/javascript">

    function DisableAllValidations() {


        ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), false);


        ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), false);


        ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), false);



        ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), false);


        ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), false);
        ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), false);
    }

    function CheckQuestion() {

        var txtQuestion = document.getElementById("<%= txtQuestion.ClientID %>").value;
        if (txtQuestion == '') {
            alert('Please enter the Risk Question!!!');
        }
    }

    function ShowOption2() {


        var txtOption = document.getElementById("<%=txtEnterOption1.ClientID%>").value;
        var txtWtage = parseInt(document.getElementById("<%=txtEnterWeightage1.ClientID%>").value);

        if ((txtOption != "") && (txtWtage != 0)) {

            if (isNaN(txtWtage)) {

                return false;
            }
            else if ((txtWtage < 1) || (txtWtage > 10)) {

                return false;
            }
            else {
                document.getElementById("<%=trOptions2.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=btnAddOption3.ClientID%>").style.visibility = "visible";

                return false;

            }
        }
        else {
            return false;
        }
    }

    function ShowOption3() {

        var txtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage1.ClientID%>").value);
        var txtOption = document.getElementById("<%=txtEnterOption2.ClientID%>").value;
        var txtWtage = parseInt(document.getElementById("<%=txtEnterWeightage2.ClientID%>").value);

        document.getElementById("<%=reqOpt2.ClientID%>").style.visibility = "visible";
        document.getElementById("<%=reqWt2.ClientID%>").style.visibility = "visible";

        if ((txtOption != "") && (txtWtage != 0)) {
            if ((isNaN(txtWtage)) || (txtPreviousWtage > txtWtage)) {

                ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);

                document.getElementById("<%=reqOpt3.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=reqWt3.ClientID%>").style.visibility = "hidden";

                return false;
            }
            else if (txtPreviousWtage == txtWtage) {
                ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);



                return false;
            }
            else if ((txtWtage < 1) || (txtWtage > 10)) {

                ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);



                return false;
            }
            else {
                document.getElementById("<%=trOptions3.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=btnOpt4.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqOpt3.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=reqWt3.ClientID%>").style.visibility = "hidden";

                return false;
            }
        }
        else {
            ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);
            return false;
        }
    }

    function ShowOption4() {

        var txtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage2.ClientID%>").value);
        var txtOption = document.getElementById("<%=txtEnterOption3.ClientID%>").value;
        var txtWtage = parseInt(document.getElementById("<%=txtEnterWeightage3.ClientID%>").value);

        document.getElementById("<%=reqOpt3.ClientID%>").style.visibility = "visible";
        document.getElementById("<%=reqWt3.ClientID%>").style.visibility = "visible";

        if ((txtOption != "") && (txtWtage != 0)) {

            if ((isNaN(txtWtage)) || (txtPreviousWtage > txtWtage)) {

                ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);

                return false;
            }
            else if (txtPreviousWtage == txtWtage) {
                ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);

                return false;
            }
            else if ((txtWtage < 1) || (txtWtage > 10)) {

                ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);

                return false;
            }
            else {

                document.getElementById("<%=trOptions4.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=btnOption5.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqOpt4.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=reqWt4.ClientID%>").style.visibility = "hidden";

                return false;
            }

        }
        else {
            ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);
            return false;
        }
    }

    function ShowOption5() {

        var txtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage3.ClientID%>").value);
        var txtOption = document.getElementById("<%=txtEnterOption4.ClientID%>").value;
        var txtWtage = parseInt(document.getElementById("<%=txtEnterWeightage4.ClientID%>").value);


        document.getElementById("<%=reqOpt4.ClientID%>").style.visibility = "visible";
        document.getElementById("<%=reqWt4.ClientID%>").style.visibility = "visible";


        if ((txtOption != "") && (txtWtage != 0)) {
            if ((isNaN(txtWtage)) || (txtPreviousWtage > txtWtage)) {

                ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);

                return false;
            }
            else if (txtPreviousWtage == txtWtage) {
                ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);

                return false;
            }
            else if ((txtWtage < 1) || (txtWtage > 10)) {

                ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);



                return false;
            }
            else {
                document.getElementById("<%=trOptions5.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=btnOpt6.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqOpt5.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=reqWt5.ClientID%>").style.visibility = "hidden";

                return false;
            }

        }
        else {
            ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);
            return false;
        }
    }

    function ShowOption6() {

        var txtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage4.ClientID%>").value);

        var txtOption = document.getElementById("<%=txtEnterOption5.ClientID%>").value;
        var txtWtage = parseInt(document.getElementById("<%=txtEnterWeightage5.ClientID%>").value);

        document.getElementById("<%=reqOpt5.ClientID%>").style.visibility = "visible";
        document.getElementById("<%=reqWt5.ClientID%>").style.visibility = "visible";

        if ((txtOption != "") && (txtWtage != 0)) {
            if ((isNaN(txtWtage)) || (txtPreviousWtage > txtWtage)) {

                ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);

                return false;
            }
            else if (txtPreviousWtage == txtWtage) {
                ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);

                return false;
            }
            else if ((txtWtage < 1) || (txtWtage > 10)) {

                ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);

                return false;
            }
            else {
                document.getElementById("<%=trOptions6.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqOpt6.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=reqWt6.ClientID%>").style.visibility = "hidden";

                return false;
            }
        }
        else {
            ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);
            return false;
        }
    }

    function ShowOption7() {

        // First Set of validation....

        var SetVeryOnetxtOption = document.getElementById("<%=txtEnterOption1.ClientID%>").value;
        var SetVeryOnetxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage1.ClientID%>").value);


        if ((SetVeryOnetxtOption == "") || (document.getElementById("<%=txtEnterWeightage1.ClientID%>").value == "")) {

            ValidatorEnable(document.getElementById("<%=compareInt1.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=RangeValidator1.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqOp1.ClientID%>"), true);
            ValidatorEnable(document.getElementById("<%=reqWt1.ClientID%>"), true);

            document.getElementById("<%=reqOp1.ClientID%>").style.visibility = "visible";
            document.getElementById("<%=reqWt1.ClientID%>").style.visibility = "visible";

            return false;
        }
        else if ((SetVeryOnetxtOption != "") && (document.getElementById("<%=txtEnterWeightage1.ClientID%>").value != "")) {

            if (isNaN(SetVeryOnetxtWtage)) {
                return false;
            }
            else if ((SetVeryOnetxtWtage < 0) || (SetVeryOnetxtWtage > 10)) {
                return false;
            }

        }



        // Second Set of validation....


        var SetOnetxtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage1.ClientID%>").value);
        var SetOnetxtOption = document.getElementById("<%=txtEnterOption2.ClientID%>").value;
        var SetOnetxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage2.ClientID%>").value);

        if (document.getElementById("<%=trOptions2.ClientID%>").style.visibility == "visible") {

            if ((SetOnetxtOption == "") || (document.getElementById("<%=txtEnterWeightage2.ClientID%>").value == "")) {

                ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);

                document.getElementById("<%=reqOpt2.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqWt2.ClientID%>").style.visibility = "visible";

                return false;
            }
            else if ((SetOnetxtOption != "") && (document.getElementById("<%=txtEnterWeightage2.ClientID%>").value != "")) {

                if ((isNaN(SetOnetxtWtage)) || (SetOnetxtPreviousWtage > SetOnetxtWtage)) {

                    ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);

                    document.getElementById("<%=reqOpt2.ClientID%>").style.visibility = "visible";
                    document.getElementById("<%=reqWt2.ClientID%>").style.visibility = "visible";
                    return false;
                }
                else if ((SetOnetxtWtage < 0) || (SetOnetxtWtage > 10)) {

                    ValidatorEnable(document.getElementById("<%=compareWt1AndWt2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt2.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt2.ClientID%>"), true);

                    return false;
                }

            }
        }
        else {

            return true;
        }


        // Third Set of validation....

        var SetSecondtxtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage2.ClientID%>").value);
        var SetSecondtxtOption = document.getElementById("<%=txtEnterOption3.ClientID%>").value;
        var SetSecondtxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage3.ClientID%>").value);

        if (document.getElementById("<%=trOptions3.ClientID%>").style.visibility == "visible") {
            if ((SetSecondtxtOption == "") || (document.getElementById("<%=txtEnterWeightage3.ClientID%>").value == "")) {

                ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);

                document.getElementById("<%=reqOpt3.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqWt3.ClientID%>").style.visibility = "visible";

                return false;
            }
            else if ((SetSecondtxtOption != "") && (document.getElementById("<%=txtEnterWeightage3.ClientID%>").value != "")) {

                if ((isNaN(SetSecondtxtWtage)) || (SetSecondtxtPreviousWtage > SetSecondtxtWtage)) {

                    ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);

                    return false;
                }
                else if ((SetSecondtxtWtage < 0) || (SetSecondtxtWtage > 10)) {

                    ValidatorEnable(document.getElementById("<%=compareWt2AndWt3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt3.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt3.ClientID%>"), true);

                    return false;
                }
            }
        }
        else {
            return true;
        }


        // Fourth Set of validation....

        var SetThirdtxtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage3.ClientID%>").value);
        var SetThirdtxtOption = document.getElementById("<%=txtEnterOption4.ClientID%>").value;
        var SetThirdtxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage4.ClientID%>").value);

        if (document.getElementById("<%=trOptions4.ClientID%>").style.visibility == "visible") {

            if ((SetThirdtxtOption == "") || (document.getElementById("<%=txtEnterWeightage4.ClientID%>").value == "")) {

                ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);

                document.getElementById("<%=reqOpt4.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqWt4.ClientID%>").style.visibility = "visible";

                return false;
            }
            else if ((SetThirdtxtOption != "") && (document.getElementById("<%=txtEnterWeightage4.ClientID%>").value != "")) {

                if ((isNaN(SetThirdtxtWtage)) || (SetThirdtxtPreviousWtage > SetThirdtxtWtage)) {

                    ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);

                    return false;
                }
                else if ((SetThirdtxtWtage < 0) || (SetThirdtxtWtage > 10)) {

                    ValidatorEnable(document.getElementById("<%=compareWt3AndWt4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt4.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt4.ClientID%>"), true);

                    return false;
                }
            }
        }
        else {
            return true;
        }


        // Fifth Set of validation....

        var SetFourthtxtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage4.ClientID%>").value);
        var SetFourthtxtOption = document.getElementById("<%=txtEnterOption5.ClientID%>").value;
        var SetFourthtxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage5.ClientID%>").value);

        if (document.getElementById("<%=trOptions5.ClientID%>").style.visibility == "visible") {
            if ((SetFourthtxtOption == "") || (document.getElementById("<%=txtEnterWeightage5.ClientID%>").value == "")) {

                ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);

                document.getElementById("<%=reqOpt5.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqWt5.ClientID%>").style.visibility = "visible";

                return false;
            }
            else if ((SetFourthtxtOption != "") && (document.getElementById("<%=txtEnterWeightage5.ClientID%>").value != "")) {

                if ((isNaN(SetFourthtxtWtage)) || (SetFourthtxtPreviousWtage > SetFourthtxtWtage)) {

                    ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);

                    return false;
                }
                else if ((SetFourthtxtWtage < 0) || (SetFourthtxtWtage > 10)) {

                    ValidatorEnable(document.getElementById("<%=compareWt4AndWt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt5.ClientID%>"), true);

                    return false;
                }
            }
        }
        else {
            return true;
        }


        // Sixth Set of validation....

        var SetFifthtxtPreviousWtage = parseInt(document.getElementById("<%=txtEnterWeightage5.ClientID%>").value);
        var SetFifthtxtOption = document.getElementById("<%=txtEnterOption6.ClientID%>").value;
        var SetFifthtxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage6.ClientID%>").value);

        if (document.getElementById("<%=trOptions6.ClientID%>").style.visibility == "visible") {
            if ((SetFifthtxtOption == "") || (document.getElementById("<%=txtEnterWeightage6.ClientID%>").value == "")) {

                ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), true);

                document.getElementById("<%=reqOpt6.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqWt6.ClientID%>").style.visibility = "visible";

                return false;
            }
            else if ((SetFifthtxtOption != "") && (document.getElementById("<%=txtEnterWeightage6.ClientID%>").value != "")) {

                if ((isNaN(SetFifthtxtWtage)) || (SetFifthtxtPreviousWtage > SetFifthtxtWtage)) {

                    ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), true);

                    return false;
                }
                else if ((SetFifthtxtWtage < 0) || (SetFifthtxtWtage > 10)) {

                    ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), true);

                    return false;
                }
            }
        }
        else {
            return true;
        }


        // Seventh Set of validation....

        var SetSixthtxtOption = document.getElementById("<%=txtEnterOption6.ClientID%>").value;
        var SetSixthtxtWtage = parseInt(document.getElementById("<%=txtEnterWeightage6.ClientID%>").value);
        if (document.getElementById("<%=trOptions6.ClientID%>").style.visibility == "visible") {
            if ((SetSixthtxtOption == "") || (document.getElementById("<%=txtEnterWeightage6.ClientID%>").value == "")) {

                ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), true);
                ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), true);

                document.getElementById("<%=reqOpt6.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=reqWt6.ClientID%>").style.visibility = "visible";

                return false;
            }
            else if ((SetSixthtxtOption != "") && (document.getElementById("<%=txtEnterWeightage6.ClientID%>").value != "")) {

                if ((isNaN(SetSixthtxtWtage))) {

                    ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), true);

                    return false;
                }
                else if ((SetSixthtxtWtage < 0) || (SetSixthtxtWtage > 10)) {

                    ValidatorEnable(document.getElementById("<%=compareWt6AndWt5.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=compareCheckInt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=RangeValidator6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqOpt6.ClientID%>"), true);
                    ValidatorEnable(document.getElementById("<%=reqWt6.ClientID%>"), true);

                    return false;
                }
            }
        }
        else {
            return true;
        }

    }
    function DisableMaintananceFormControls() {

        var Controls_to_disable = document.getElementById('<%=pnlAdviserQuestionsMaintanance.ClientID %>').getElementsByTagName("input");
        var children = Controls_to_disable; //.childNodes;
        for (var i = 0; i < children.length; i++) {
            children[i].disabled = true;
        };

        var Controls_to_disable1 = document.getElementById('<%=pnlAdviserQuestionsMaintanance.ClientID %>').getElementsByTagName("textarea");
        var children1 = Controls_to_disable1; //.childNodes;
        for (var i = 0; i < children1.length; i++) {
            children1[i].disabled = true;
        };

        document.getElementById('ctrl_RiskScore_btnSubmitAndEnterNewQuestion').style.visibility = "hidden";
        document.getElementById('ctrl_RiskScore_btnSubmit').style.visibility = "hidden";
    }

    function EnableMaintananceFormControls() {

        var Controls_to_Enable = document.getElementById('<%=pnlAdviserQuestionsMaintanance.ClientID %>').getElementsByTagName("input");
        var children = Controls_to_Enable; //.childNodes;
        for (var i = 0; i < children.length; i++) {
            children[i].disabled = false;
        };

        var Controls_to_Enable1 = document.getElementById('<%=pnlAdviserQuestionsMaintanance.ClientID %>').getElementsByTagName("textarea");
        var children1 = Controls_to_Enable1; //.childNodes;
        for (var i = 0; i < children1.length; i++) {
            children1[i].disabled = false;
        };

        document.getElementById('ctrl_RiskScore_btnSubmitAndEnterNewQuestion').style.visibility = "visible";
        document.getElementById('ctrl_RiskScore_btnSubmit').style.visibility = "visible";
    }

    function DeleteConfirmation() {

        var bool = window.confirm('Are you sure you want to delete this Question?');

        if (bool) {
            document.getElementById("ctrl_RiskScore_hdnDeletemsgValue").value = 1;
            document.getElementById("ctrl_RiskScore_hiddenDeleteQuestion").click();

            return false;
        }
        else {
            return false;
        }
    }

</script>

<script type="text/javascript">
    function showmessage() {
        alert('Risk Score is not proper');
    }
</script>

<script type="text/javascript">
    function showAlertmessage() {
        alert('Min Score and Max Score is not covered');
    }
</script>

<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
</telerik:RadScriptManager>
<telerik:RadTabStrip ID="RadTabStrip1" runat="server" EnableTheming="True" Skin="Telerik"
    EnableEmbeddedSkins="False" MultiPageID="RiskScoreCalculationId" SelectedIndex="0">
    <Tabs>
        <telerik:RadTab runat="server" Text="Risk Score" onclick="HideStatusMsg()" Value="RiskScore"
            TabIndex="0" Selected="True">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="Risk Questions and Scores" onclick="HideStatusMsg()"
            Value="RiskQuestionsandScores" TabIndex="1" Selected="True">
        </telerik:RadTab>
    </Tabs>
</telerik:RadTabStrip>
<telerik:RadMultiPage ID="RiskScoreCalculationId" EnableViewState="true" runat="server"
    SelectedIndex="0">
    <telerik:RadPageView ID="RadPageView1" runat="server">
        <asp:Panel ID="pnlRiskScore" runat="server">
            <table class="TableBackground" style="width: 100%;">
                <tr>
                    <td>
                        <asp:Label ID="lblSetUpScore" runat="server" CssClass="HeaderTextBig" Text="Set up risk scores for the risk classes"></asp:Label>
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <label id="Label12" class="FieldName">
                            Current Min Riskscore:
                        </label>
                        &nbsp;
                        <asp:TextBox ID="txtMinScore" CssClass="txtField" Enabled="false" ReadOnly="true"
                            runat="server">
                        </asp:TextBox>
                        &nbsp;&nbsp;
                        <label id="Label14" class="FieldName">
                            Current Max Riskscore:
                        </label>
                        &nbsp;
                        <asp:TextBox ID="txtMaxScore" CssClass="txtField" Enabled="false" ReadOnly="true"
                            runat="server">
                        </asp:TextBox>
                    </td>
                </tr>
            </table>
            <table style="width: 100%">
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Panel ID="pnl" runat="server" ScrollBars="Horizontal" Height="200px">
                            <telerik:RadGrid ID="RadGrid1" runat="server" CssClass="RadGrid" GridLines="None"
                                AllowPaging="True" PageSize="20" AllowSorting="True" AutoGenerateColumns="False"
                                Skin="Telerik" ShowStatusBar="true" AllowAutomaticDeletes="false" AllowAutomaticInserts="False"
                                OnItemDataBound="RadGrid1_ItemDataBound" OnInsertCommand="RadGrid1_InsertCommand"
                                OnUpdateCommand="RadGrid1_UpdateCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
                                OnItemCommand="RadGrid1_ItemCommand" OnPreRender="RadGrid1_PreRender" AllowAutomaticUpdates="False"
                                HorizontalAlign="NotSet" DataKeyNames="XRC_RiskClassCode">
                                <MasterTableView EditMode="PopUp" DataKeyNames="XRC_RiskClassCode" TableLayout="Fixed"
                                    Width="100%">
                                    <Columns>
                                        <telerik:GridEditCommandColumn HeaderText="Edit">
                                            <HeaderStyle Width="20%" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn UniqueName="XRC_RiskClass" HeaderText="Risk Class" DataField="XRC_RiskClass">
                                            <HeaderStyle Width="30%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="WRPR_RiskScoreLowerLimit" HeaderText="Lower Limit"
                                            DataField="WRPR_RiskScoreLowerLimit">
                                            <HeaderStyle Width="25%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="WRPR_RiskScoreUpperLimit" HeaderText="Upper Limit"
                                            DataField="WRPR_RiskScoreUpperLimit">
                                            <HeaderStyle Width="25%" />
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn UniqueName="CPA_Value" HeaderText="Value" DataField="CPA_Value" >
                    </telerik:GridBoundColumn>--%>
                                        <%--<telerik:GridButtonColumn CommandName="Delete" Text="Delete" UniqueName="column">
                    </telerik:GridButtonColumn>--%>
                                    </Columns>
                                    <EditFormSettings InsertCaption="Add" FormTableStyle-HorizontalAlign="Center" PopUpSettings-Modal="true"
                                        PopUpSettings-ZIndex="60" CaptionFormatString="Edit" EditFormType="Template">
                                        <%--CaptionDataField="CPA_Value"--%>
                                        <FormTemplate>
                                            <table id="Table1" cellspacing="1" cellpadding="1" width="100%" border="0">
                                                <tr id="trPickClassDdl" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblPickClass" runat="server" Text="Pick a Risk class :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlPickRiskClass" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trRisktextBox" runat="server">
                                                    <td class="leftField">
                                                        <asp:Label ID="lblRisk" runat="server" Text="Pick a Risk class :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightField">
                                                        <asp:TextBox ID="txtRiskClass" CssClass="txtField" ReadOnly="true" Text='<%# Bind( "XRC_RiskClass") %>'
                                                            runat="server">
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftField">
                                                        <asp:Label ID="lblLowerLimit" runat="server" Text="Lower Limit :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLowerLimit" CssClass="txtField" Text='<%# Bind( "WRPR_RiskScoreLowerLimit") %>'
                                                            runat="server">
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftField">
                                                        <asp:Label ID="lblUpperLimit" runat="server" Text="Upper Limit :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtUpperLimit" CssClass="txtField" Text='<%# Bind( "WRPR_RiskScoreUpperLimit") %>'
                                                            runat="server">
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" colspan="2">
                                                        <asp:Button ID="Button1" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                            runat="server" CssClass="PCGButton" OnClientClick="return Validate()" ValidationGroup="vgbtnSubmit"
                                                            CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                                        </asp:Button>&nbsp;
                                                        <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="False"
                                                            CommandName="Cancel"></asp:Button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </FormTemplate>
                                    </EditFormSettings>
                                </MasterTableView>
                                <ClientSettings>
                                    <%--<ClientEvents OnRowDblClick="RowDblClick" />--%>
                                </ClientSettings>
                            </telerik:RadGrid>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnSubmitRiskScore" CssClass="PCGLongButton" Text="Submit" runat="server"
                            OnClick="btnSubmitRiskScore_Click"></asp:Button>
                        <asp:Button ID="btnRiskScoreReset" CssClass="PCGLongButton" Text="Reset Score" runat="server"
                            OnClick="btnRiskScoreReset_Click"></asp:Button>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </telerik:RadPageView>
    <telerik:RadPageView ID="RadPageView2" runat="server">
        <asp:Panel ID="pnlAdviserQuestionsDisplay" runat="server">
            <table id="tblAdviserQuestionsDisplay" style="width: 100%" runat="server">
                <tr>
                    <td align="center">
                        <div id="msgNoRecords" runat="server" class="failure-msg" align="center" visible="false">
                            No Questions found for this adviser..
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="HeaderTextBig">
                        <asp:Label ID="lblHeader" runat="server" CssClass="HeaderTextBig" Text="Risk Profile Questions and options."></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <label id="lblshowMinScroe" class="cmbField">
                            Current Min Riskscore:
                        </label>
                        &nbsp;
                        <asp:Label ID="lblMinScore" runat="server" Text="" CssClass="cmbField"></asp:Label>
                        &nbsp;&nbsp;
                        <label id="lblshowMaxScore" class="cmbField">
                            Current Max Riskscore:
                        </label>
                        &nbsp;
                        <asp:Label ID="lblMaxScore" runat="server" Text="" CssClass="cmbField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button ID="btnAddQuestions" runat="server" CssClass="PCGMediumButton" Text="AddQuestions"
                            OnClick="btnAddQuestions_Click" />
                    </td>
                </tr>
            </table>
            <asp:Panel ID="mainpnl" runat="server" ScrollBars="Vertical">
                <table>
                    <tr runat="server" id="trAdviserQuestionDisplay">
                        <td>
                            <asp:Repeater ID="repAdviserQuestions" OnItemCommand="repAdviserQuestions_ItemCommand"
                                runat="server">
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <hr />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkQuestions" CssClass="FieldName" runat="server" CommandArgument='<%# Eval("QM_QuestionID") %>'
                                                    Text='<%# Eval("QM_Question").ToString() %>' CommandName="QuestionEditUpdateLink"></asp:LinkButton>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOption1" CssClass="txtField" runat="server" Text='<%# Eval("QM_QuestionOption1").ToString() %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOption2" CssClass="txtField" runat="server" Text='<%# Eval("QM_QuestionOption2").ToString() %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOption3" CssClass="txtField" runat="server" Text='<%# Eval("QM_QuestionOption3").ToString() %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOption4" CssClass="txtField" runat="server" Text='<%# Eval("QM_QuestionOption4").ToString() %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOption5" CssClass="txtField" runat="server" Text='<%# Eval("QM_QuestionOption5").ToString() %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOption6" CssClass="txtField" runat="server" Text='<%# Eval("QM_QuestionOption6").ToString() %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                                <SeparatorTemplate>
                                    <br />
                                </SeparatorTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>
        <asp:Panel ID="pnlMaintanceFormTitle" runat="server">
            <table width="100%" id="MaintanceFormTitle" runat="server" class="TableBackground">
                <tr>
                    <td class="HeaderCell">
                        <img src="../Images/helpImage.png" height="25px" width="25px" style="float: right;"
                            class="flip" />
                        <asp:Label ID="Label10" runat="server" CssClass="HeaderTextBig" Text="Set Risk Questions and scores."></asp:Label>
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div class="panel" style="font-size: small">
                            <p style="font-size: smaller; text-decoration: underline;">
                                Rules for adding Option Weightage:</p>
                            <p style="font-size: smaller">
                                1) Weightage must be between 0 and 10.</p>
                            <p style="font-size: smaller">
                                2) Weightage must be in increasing order.</p>
                        </div>
                    </td>
                </tr>
            </table>
            <%--<table id="MaintanceFormTitle" runat="server" width="100%">
    <tr>
        <td class="HeaderTextBig">
            <asp:Label ID="Label9" runat="server" CssClass="HeaderTextBig" Text="Set Risk Questions and scores."></asp:Label>
                <hr />
        </td>
    </tr>
</table>--%>
            <table runat="server" id="tblEditForm" width="30%">
                <tr>
                    <td runat="server" id="tdback">
                        <asp:Button ID="btnBack" runat="server" CssClass="PCGButton" Text="Back" OnClick="btnBack_Click" />
                    </td>
                    <td runat="server" id="tdEditForm">
                        <input type="button" class="PCGButton" onclick="EnableMaintananceFormControls();"
                            value="Edit" />
                    </td>
                    <td runat="server" id="tdDelete">
                        <asp:Button ID="btnDeleteQuestions" CssClass="PCGLongButton" OnClientClick="return DeleteConfirmation()"
                            runat="server" Text="Delete Question" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlAdviserQuestionsMaintanance" runat="server" ScrollBars="Horizontal"
           >
            <table id="tblAdviserQuestionMaintainance" width="100%">
                <tr id="trAdviserQuestionMaintance">
                    <td style="width: 15%;">
                        <label id="lblEnterQuestion" class="HeaderText">
                            Enter the Question:
                        </label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtQuestion" Width="500px" Height="100px" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td style="width: 10%">
                        &nbsp;
                    </td>
                    <td style="width: 10%">
                        <label id="Label2" style="text-decoration: underline;" class="HeaderTextSmall">
                            Options:
                        </label>
                    </td>
                    <td style="width: 10%">
                        <label id="Label8" style="text-decoration: underline;" class="HeaderTextSmall">
                            Weightage:
                        </label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr runat="server" id="trOptions1">
                    <td style="width: 5%;">
                        <label id="Label1" class="HeaderText">
                            Option 1:
                        </label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtEnterOption1" TextMode="MultiLine" onfocus="CheckQuestion()"
                            runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:TextBox ID="txtEnterWeightage1" onfocus="CheckQuestion()" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top; width: 20px;">
                        <asp:ImageButton ID="btnAddOp2" runat="server" ValidationGroup="ValidateQuestionOptions"
                            OnClientClick="return ShowOption2()" ImageUrl="~/Images/AddPlus.png" />
                    </td>
                    <td>
                        <asp:CompareValidator ID="compareInt1" ValidationGroup="ValidateQuestionOptions"
                            CssClass="FieldName" Display="Dynamic" runat="server" Operator="DataTypeCheck"
                            Type="Integer" ControlToValidate="txtEnterWeightage1" ErrorMessage="Please Enter Numeric Value!" />
                        <asp:RangeValidator ID="RangeValidator1" ValidationGroup="ValidateQuestionOptions"
                            CssClass="FieldName" Display="Dynamic" runat="server" Type="Integer" MinimumValue="1"
                            MaximumValue="10" ControlToValidate="txtEnterWeightage1" ErrorMessage="Weightage must be between 1 and 10!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqOp1" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            ControlToValidate="txtEnterOption1" Display="Dynamic" ErrorMessage="Please Enter the Option!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqWt1" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage1" ErrorMessage="Please Enter the Weightage!" />
                    </td>
                </tr>
                <tr runat="server" id="trOptions2" style="visibility: hidden">
                    <td style="width: 5%;">
                        <label id="Label3" class="HeaderText">
                            Option 2:
                        </label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEnterOption2" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:TextBox ID="txtEnterWeightage2" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <%--<asp:Button ID="btnAddOption3" runat="server" ValidationGroup="ValidateQuestionOptions" Text="Add" class="PCGButton" OnClientClick="ShowOption3()" />--%>
                        <asp:ImageButton ID="btnAddOption3" runat="server" ValidationGroup="ValidateQuestionOptions"
                            OnClientClick="return ShowOption3()" ImageUrl="~/Images/AddPlus.png" />
                    </td>
                    <td>
                        <asp:CompareValidator runat="server" ValidationGroup="ValidateQuestionOptions" ID="compareWt1AndWt2"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage2" CssClass="FieldName"
                            ControlToCompare="txtEnterWeightage1" Operator="GreaterThan" Type="Integer" ErrorMessage="The Second Weightage should be greater than the first weightage!" />
                        <asp:CompareValidator ID="compareCheckInt2" ValidationGroup="ValidateQuestionOptions"
                            runat="server" CssClass="FieldName" Operator="DataTypeCheck" Display="Dynamic"
                            Type="Integer" ControlToValidate="txtEnterWeightage2" ErrorMessage="Please Enter Numeric Value!" />
                        <asp:RangeValidator ID="RangeValidator2" ValidationGroup="ValidateQuestionOptions"
                            runat="server" CssClass="FieldName" Type="Integer" Display="Dynamic" MinimumValue="1"
                            MaximumValue="10" ControlToValidate="txtEnterWeightage2" ErrorMessage="Weightage must be between 1 and 10!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqOpt2" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            ControlToValidate="txtEnterOption2" Display="Dynamic" ErrorMessage="Please Enter the Option!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqWt2" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage2" ErrorMessage="Please Enter the Weightage!" />
                    </td>
                </tr>
                <tr runat="server" id="trOptions3" style="visibility: hidden">
                    <td>
                        <label id="Label4" class="HeaderText">
                            Option 3:
                        </label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEnterOption3" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:TextBox ID="txtEnterWeightage3" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:ImageButton ID="btnOpt4" runat="server" ValidationGroup="ValidateQuestionOptions"
                            OnClientClick="return ShowOption4()" ImageUrl="~/Images/AddPlus.png" />
                    </td>
                    <td>
                        <asp:CompareValidator runat="server" ValidationGroup="ValidateQuestionOptions" ID="compareWt2AndWt3"
                            Display="Dynamic" CssClass="FieldName" ControlToValidate="txtEnterWeightage3"
                            ControlToCompare="txtEnterWeightage2" Operator="GreaterThan" Type="Integer" ErrorMessage="The Third Weightage should be greater than the second weightage!" />
                        <asp:CompareValidator ID="compareCheckInt3" ValidationGroup="ValidateQuestionOptions"
                            runat="server" Display="Dynamic" CssClass="FieldName" Operator="DataTypeCheck"
                            Type="Integer" ControlToValidate="txtEnterWeightage3" ErrorMessage="Please Enter Numeric Value!" />
                        <asp:RangeValidator ID="RangeValidator3" runat="server" ValidationGroup="ValidateQuestionOptions"
                            CssClass="FieldName" Type="Integer" MinimumValue="1" MaximumValue="10" ControlToValidate="txtEnterWeightage3"
                            Display="Dynamic" ErrorMessage="Weightage must be between 1 and 10!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqOpt3" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            ControlToValidate="txtEnterOption3" Display="Dynamic" ErrorMessage="Please Enter the Option!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqWt3" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage3" ErrorMessage="Please Enter the Weightage!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr runat="server" id="trOptions4" style="visibility: hidden">
                    <td>
                        <label id="Label5" class="HeaderText">
                            Option 4:
                        </label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEnterOption4" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:TextBox ID="txtEnterWeightage4" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:ImageButton ID="btnOption5" runat="server" ValidationGroup="ValidateQuestionOptions"
                            OnClientClick="return ShowOption5()" ImageUrl="~/Images/AddPlus.png" />
                    </td>
                    <td>
                        <asp:CompareValidator runat="server" ValidationGroup="ValidateQuestionOptions" ID="compareWt3AndWt4"
                            Display="Dynamic" CssClass="FieldName" ControlToValidate="txtEnterWeightage4"
                            ControlToCompare="txtEnterWeightage3" Operator="GreaterThan" Type="Integer" ErrorMessage="The Fourth Weightage should be greater than the third weightage!" />
                        <asp:CompareValidator ID="compareCheckInt4" ValidationGroup="ValidateQuestionOptions"
                            CssClass="FieldName" runat="server" Display="Dynamic" Operator="DataTypeCheck"
                            Type="Integer" ControlToValidate="txtEnterWeightage4" ErrorMessage="Please Enter Numeric Value!" />
                        <asp:RangeValidator ID="RangeValidator4" ValidationGroup="ValidateQuestionOptions"
                            CssClass="FieldName" runat="server" Type="Integer" MinimumValue="1" MaximumValue="10"
                            ControlToValidate="txtEnterWeightage4" Display="Dynamic" ErrorMessage="Weightage must be between 1 and 10!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqOpt4" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            ControlToValidate="txtEnterOption4" Display="Dynamic" ErrorMessage="Please Enter the Option!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqWt4" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage4" ErrorMessage="Please Enter the Weightage!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr runat="server" id="trOptions5" style="visibility: hidden">
                    <td>
                        <label id="Label6" class="HeaderText">
                            Option 5:
                        </label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEnterOption5" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:TextBox ID="txtEnterWeightage5" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:ImageButton ID="btnOpt6" runat="server" ValidationGroup="ValidateQuestionOptions"
                            OnClientClick="return ShowOption6()" ImageUrl="~/Images/AddPlus.png" />
                    </td>
                    <td>
                        <asp:CompareValidator runat="server" ID="compareWt4AndWt5" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" CssClass="FieldName" ControlToValidate="txtEnterWeightage5"
                            ControlToCompare="txtEnterWeightage4" Operator="GreaterThan" Type="Integer" ErrorMessage="The Fifth Weightage should be greater than the fourth weightage!" />
                        <asp:CompareValidator ID="compareCheckInt5" runat="server" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" CssClass="FieldName" Operator="DataTypeCheck" Type="Integer"
                            ControlToValidate="txtEnterWeightage5" ErrorMessage="Please Enter Numeric Value!" />
                        <asp:RangeValidator ID="RangeValidator5" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            runat="server" Type="Integer" MinimumValue="1" MaximumValue="10" ControlToValidate="txtEnterWeightage5"
                            Display="Dynamic" ErrorMessage="Weightage must be between 1 and 10!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqOpt5" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            ControlToValidate="txtEnterOption5" Display="Dynamic" ErrorMessage="Please Enter the Option!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqWt5" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage5" ErrorMessage="Please Enter the Weightage!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr runat="server" id="trOptions6" style="visibility: hidden">
                    <td>
                        <label id="Label7" class="HeaderText">
                            Option 6:
                        </label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEnterOption6" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:TextBox ID="txtEnterWeightage6" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:CompareValidator runat="server" ID="compareWt6AndWt5" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" CssClass="FieldName" ControlToValidate="txtEnterWeightage6"
                            ControlToCompare="txtEnterWeightage5" Operator="GreaterThan" Type="Integer" ErrorMessage="The Sixth Weightage should be greater than the fifth weightage!" />
                        <asp:CompareValidator CssClass="FieldName" ID="compareCheckInt6" ValidationGroup="ValidateQuestionOptions"
                            runat="server" Display="Dynamic" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtEnterWeightage6"
                            ErrorMessage="Please Enter Numeric Value!" />
                        <asp:RangeValidator CssClass="FieldName" ID="RangeValidator6" ValidationGroup="ValidateQuestionOptions"
                            runat="server" Type="Integer" MinimumValue="1" MaximumValue="10" ControlToValidate="txtEnterWeightage6"
                            Display="Dynamic" ErrorMessage="Weightage must be between 1 and 10!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqOpt6" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            ControlToValidate="txtEnterOption6" Display="Dynamic" ErrorMessage="Please Enter the Option!" />
                        <asp:RequiredFieldValidator runat="server" ID="reqWt6" CssClass="FieldName" ValidationGroup="ValidateQuestionOptions"
                            Display="Dynamic" ControlToValidate="txtEnterWeightage6" ErrorMessage="Please Enter the Weightage!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr runat="server" id="tr7">
                    <td>
                        <asp:Button ID="btnSubmitAndEnterNewQuestion" OnClientClick="return ShowOption7()"
                            ValidationGroup="ValidateQuestionOptions" CssClass="PCGLongButton" runat="server"
                            Text="Submit & Add new question" OnClick="btnSubmitAndEnterNewQuestion_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnSubmit" runat="server" OnClientClick="return ShowOption7()" ValidationGroup="ValidateQuestionOptions"
                            CssClass="PCGButton" Text="Submit" OnClick="btnSubmit_Click" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </telerik:RadPageView>
</telerik:RadMultiPage>
<asp:HiddenField ID="hdnDeletemsgValue" runat="server" />
<div style="visibility: hidden">
    <asp:Button ID="hiddenDeleteQuestion" runat="server" OnClick="hiddenDeleteQuestion_Click"
        BorderStyle="None" BackColor="Transparent" />
</div>
