$(document).ready(function () {
  // Wires a <select id="selectId"> (options already rendered server-side)
  // to a DataTables column search, matching whole values inside
  // semicolon-separated cells like "Stata; R".
  function wireColumnFilter(api, selectId, columnIndex) {
    var select = $("#" + selectId);
    if (select.length === 0) return;

    var column = api.column(columnIndex);
    select.on("change", function () {
      var val = $(this).val();
      if (!val) {
        column.search("").draw();
        return;
      }
      var escaped = $.fn.dataTable.util.escapeRegex(val);
      // Match the whole value even when the cell wraps it in a link, e.g.
      // '...">CITOTAB</a>; <a...' -- boundaries can be ';', string start/end,
      // or the '>'/'<' either side of an <a> tag.
      var pattern = "(^|;\\s*|>)" + escaped + "(\\s*;|$|<)";
      column.search(pattern, true, false).draw();
    });
  }

  function initFilterableTable(tableId, filters) {
    var table = $(tableId).DataTable({ pageLength: 50 });
    filters.forEach(function (f) {
      wireColumnFilter(table, f.selectId, f.columnIndex);
    });
    return table;
  }

  // Column indexes correspond to the <thead> order in index.html.
  var cbsTable = initFilterableTable("#cbsTable", [
    { selectId: "cbsLanguageFilter", columnIndex: 3 }, // Code Language
    { selectId: "cbsDataFilter", columnIndex: 5 }, // Data used
    { selectId: "cbsDataDesignFilter", columnIndex: 8 }, // Data design
  ]);

  var lissTable = initFilterableTable("#lissTable", [
    { selectId: "lissLanguageFilter", columnIndex: 3 }, // Code language
  ]);

  var portTable = initFilterableTable("#portTable", [
    { selectId: "portPlatformFilter", columnIndex: 1 }, // Platform
    { selectId: "portMethodFilter", columnIndex: 2 }, // Method
  ]);

  // DataTables can miscalculate column widths when initialized on a
  // hidden (x-show="false") table. Recalculate whenever a tab is shown.
  $(".nav-pills button, .dropdown-item").on("click", function () {
    setTimeout(function () {
      cbsTable.columns.adjust();
      lissTable.columns.adjust();
      portTable.columns.adjust();
    }, 0);
  });
});
