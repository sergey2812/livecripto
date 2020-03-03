$(function () {
    $('.date').each(function () {
        $(this).text(formatDate($(this).text()));
    });
    $('.time').each(function () {
        $(this).text(formatTime($(this).text()));
    });
});

function formatDate(date) {
    let timeInclude = false;
    if (date.indexOf(':') > -1) {
        timeInclude = true;
        date = date.replace(/^(\d{2}).(\d{2}).(\d{4}) (\d{2}):(\d{2})/,'$3-$2-$1 $4:$5');
    } else{
        date = date.replace(/^(\d{2}).(\d{2}).(\d{4})/,'$3-$2-$1');
    }

    let dateObject = new Date(date);
    let offset = dateObject.getTimezoneOffset() / 60;
    let serverOffset = -3;
    let newOffset = serverOffset - offset;

    dateObject.setHours(dateObject.getHours() + newOffset);

    console.log(date, dateObject, newOffset);

    return formatDateString(dateObject, timeInclude);
}

function formatTime(time) {
    let dateObject = new Date();

    time = time.split(":");
    dateObject.setHours(time[0]);
    dateObject.setMinutes(time[1]);

    let offset = dateObject.getTimezoneOffset() / 60;
    let serverOffset = -3;
    let newOffset = serverOffset - offset;

    dateObject.setHours(dateObject.getHours() + newOffset);

    console.log(time, dateObject, newOffset);

    return formatTimeString(dateObject);
}

function formatTimeString(date) {
    let hh = date.getHours();
    if (hh < 10) hh = '0' + hh;

    let mm = date.getMinutes();
    if (mm < 10) mm = '0' + mm;

    return hh + ":" + mm;
}
function formatDateString(date, time) {
    let dd = date.getDate();
    if (dd < 10) dd = '0' + dd;

    let mm = date.getMonth() + 1;
    if (mm < 10) mm = '0' + mm;

    let yy = date.getFullYear() % 100;
    if (yy < 10) yy = '0' + yy;

    let result = dd + '.' + mm + '.' + yy;
    if (time) {
        result += " " + formatTimeString(date);
    }

    return result;
}