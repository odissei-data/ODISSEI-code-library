$(document).ready(function () {
  // Splits multi-value cells like "Stata; R" and builds a <select> filter
  // for a given column, wired to DataTables' column search.
  function addColumnFilter(api, selectId, columnIndex) {
    var select = $("#" + selectId);
    if (select.length === 0) return; // filter UI not present for this table, skip

    var column = api.column(columnIndex);
    var values = column
      .data()
      .toArray()
      .flatMap(function (v) {
        return String(v)
          .split(";")
          .map(function (s) {
            return s.trim();
          });
      })
      .filter(function (v, i, arr) {
        return v && v.toLowerCase() !== "na" && arr.indexOf(v) === i;
      })
      .sort(function (a, b) {
        return a.localeCompare(b);
      });

    values.forEach(function (v) {
      select.append('<option value="' + v.replace(/"/g, "&quot;") + '">' + v + "</option>");
    });

    select.on("change", function () {
      var val = $(this).val();
      if (!val) {
        column.search("").draw();
        return;
      }
      var escaped = $.fn.dataTable.util.escapeRegex(val);
      // Match the value as a whole entry even inside "A; B; C" style cells
      var pattern = "(^|;\\s*)" + escaped + "(\\s*;|$)";
      column.search(pattern, true, false).draw();
    });
  }

  function initFilterableTable(tableId, filters) {
    var table = $(tableId).DataTable({
      pageLength: 50,
      initComplete: function () {
        var api = this.api();
        filters.forEach(function (f) {
          addColumnFilter(api, f.selectId, f.columnIndex);
        });
      },
    });
    return table;
  }

  // Column indexes correspond to the <thead> order in index.html.
  var cbsTable = initFilterableTable("#cbsTable", [
    { selectId: "cbsLanguageFilter", columnIndex: 3 }, // Code Language
    { selectId: "cbsDataFilter", columnIndex: 5 }, // Data used
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
