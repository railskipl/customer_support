function OnMobileMenuClick() {
    if ($("#mobileToolbar").is(":visible")) {
        $("#mobileToolbar").hide();        
    }
    else {
        $("#mobileToolbar ul li ul").each(function () {
            $(this).hide();
        });
        $("#mobileToolbar").show();
    }
    return false;

}
function OnMobileSubMenuClick(objThis) {
    if (objThis.next("ul").is(":visible")) {
        objThis.next("ul").hide();
    }
    else {
        $("#mobileToolbar ul li ul").each(function () {
            $(this).hide(); 
        });
        objThis.next("ul").show();
    }
    
    return false;
}