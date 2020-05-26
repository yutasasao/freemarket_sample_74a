$(document).on("turbolinks:load", function() {
  カテゴリーセレクトボックスのオプションを作成
  function appendOption(variable) {
    var html = `<option value="${variable.id}">${variable.name}</option>`;
    return html;
  }

  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML) {
    var childSelectHtml = "";
    childSelectHtml = `<div class="children-wrapper">
                        <select id="select-children-category" name="item[category_id]"><option value="">---</option>
                          ${insertHTML}
                        </select>
                          <div class="select-arrow">
                            <i class="fas fa-chevron-down"></i>
                          </div>
                       </div>`;
    $(".sale-form-details__category--select").append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML) {
    var grandchildSelectHtml = "";
    grandchildSelectHtml = `<div class="grandchildren-wrapper">
                            <select id="select-grandchildren-category" name="item[category_id]"><option value="">---</option>
                              ${insertHTML}
                            </select>
                              <div class="select-arrow">
                                <i class="fas fa-chevron-down"></i>
                              </div>
                            </div>`;
    $(".sale-form-details__category--select").append(grandchildSelectHtml);
  }

  // 親カテゴリー選択後のイベント
  $("#select-parent-category").on("change", function() {
    var parentCategory = document.getElementById("select-parent-category")
      .value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "") {
      //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/sales/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: "json"
      })
        .done(function(children) {
          $(".children-wrapper").remove(); //親が変更された時、子以下を削除する
          $(".grandchildren-wrapper").remove();
          $("#size_wrapper").remove();
          var insertHTML = "";
          children.forEach(function(child) {
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function() {
          alert("カテゴリー取得に失敗しました");
        });
    } else {
      $(".children-wrapper").remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $(".grandchildren-wrapper").remove();
      $("#size_wrapper").remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $(document).on("change", "#select-children-category", function() {
    var childId = $("#select-children-category").val(); //選択された子カテゴリーのidを取得
    if (childId != "") {
      //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/sales/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: "json"
      })
        .done(function(grandchildren) {
          if (grandchildren.length != 0) {
            $(".grandchildren-wrapper").remove(); //子が変更された時、孫以下を削除する
            $("#size_wrapper").remove();
            var insertHTML = "";
            grandchildren.forEach(function(grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function() {
          alert("カテゴリー取得に失敗しました");
        });
    } else {
      $(".grandchildren-wrapper").remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $("#size_wrapper").remove();
    }
  });
});