$(document).on("turbolinks:load", function() {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(variable) {
    var html = `<option value="${variable.id}">${variable.name}</option>`;
    return html;
  }
  // 配送方法用のセレクトボックスのオプションを作成
  function appendShippingMethodOption(variable){
    var html = `<option value="${variable.name}">${variable.name}</option>`;
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
  // サイズが必要か判定
  function judgeSize(id) {
    if (20 <= id && id <= 85) {
      return true;
    } else if (91 <= id && id <= 144) {
      return true;
    } else if (150 <= id && id <= 164) {
      return true;
    } else {
      return false;
    }
  }
  // サイズの入力フォーム作成
  function appendSizeForm() {
    var appendSizeFormHtml = "";
    appendSizeFormHtml = `<div id="size_wrapper">
                            <div class="sell-item__form">
                            <label class="sell-item__form--subject">サイズ</label>
                            <span class="sell-item__form--essential">必須</span>
                            <input placeholder="サイズ（必須） （S,M,L,靴のサイズ等）" class="sell-item__form--size" type="text" name="item[size]" id="item_size">
                            </div>
                            </div>`;
    $(".sale-form-details__category--select").append(appendSizeFormHtml);
  }

  // 配送方法選択フォーム作成
  function appendShippingMetodBox(insertHTML) {
    var ShippingMethodHtml = "";
    ShippingMethodHtml = `<div class="shipping_method-wrapper">
                        <label class="select-subject">配送の方法</label>
                        <span class="select-essential">必須</span>
                        <div class="shipping_method-select-wrapper">
                        <select id="select-shipping_method" name="item[shipping_method]"><option value="">---</option>
                          ${insertHTML}
                        </select>
                          <div class="select-arrow">
                            <i class="fas fa-chevron-down"></i>
                          </div>
                          </div>
                        </div>`;
    $(".sale-form-delivery__fee--menu").append(ShippingMethodHtml);
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

  // 孫カテゴリ選択後、サイズ欄を表出する処理
  $(document).on("change", "#select-grandchildren-category", function() {
    var grandChildId = $("#select-grandchildren-category").val(); //選択された孫カテゴリーのidを取得
    if (judgeSize(grandChildId)) {
      //サイズが必要なカテゴリか判定
      $("#size_wrapper").remove();
      appendSizeForm();
    } else {
      $("#size_wrapper").remove();
    }
  });

  // 配送料の負担選択後、発送方法欄を表出する処理
  $(document).on("change", "#item_shipping_price", function() {
    var ShippingPriceId = $("#item_shipping_price").val();
    if (ShippingPriceId != "") {
      $.ajax({
        url: '/sales/get_shipping_method',
        type: 'GET',
        data: { shipping_price_id: ShippingPriceId },
        dataType: 'json'
      })
      .done(function(shippingMethod){
        if (shippingMethod.length != 0) {
          $('.shippingMethod-wrapper').remove(); 
          var insertHTML = '';
          shippingMethod.forEach(function(shippingMethod){
          insertHTML += appendShippingMethodOption(shippingMethod);
          });
          appendShippingMethodBox(insertHTML);
        }
      })
      .fail(function() {
        alert("配送方法取得に失敗しました");
      });
    } else {
      $(".shippingmethod-wrapper").remove();
    }
  });

  //販売手数料と販売利益を計算
  $("#item_price").on("keyup", function() {
    var input = $("#item_price").val();
    if (
      300 <= input &&
      input <= 9999999 &&
      Math.round(input) == input &&
      input != 0
    ) {
      //数値が範囲内か、少数でないか、0でないかチェックする
      var fee = Math.floor(input * 0.1);
      var profit = input - fee;
      var feeDefault = $(".result-fee").text();
      var profitDefault = $(".result-profit").text();
      var feeResult = feeDefault.replace(feeDefault, "¥" + String(fee));
      var profitResult = profitDefault.replace(
        profitDefault,
        "¥" + String(profit)
      );
      $(".result-fee").text(feeResult);
      $(".result-profit").text(profitResult);
    } else {
      var feeDefault = $(".result-fee").text();
      var profitDefault = $(".result-profit").text();
      var feeResult = feeDefault.replace(feeDefault, "-");
      var profitResult = profitDefault.replace(profitDefault, "-");
      $(".result-fee").text(feeResult);
      $(".result-profit").text(profitResult);
    }
  })

  $(window).on('load', function() {
    var input = $("#item_price").val();
    if (300 <= input && input <= 9999999 && Math.round(input) == input && input!=0){  //数値が範囲内か、少数でないか、0でないかチェックする
      var fee = Math.floor(input * 0.1);
      var profit = input - fee;
      var feeDefault = $('.result-fee').text();
      var profitDefault = $('.result-profit').text();
      var feeResult = feeDefault.replace(feeDefault, "¥"+String(fee));
      var profitResult = profitDefault.replace(profitDefault, "¥"+String(profit));
      $('.result-fee').text(feeResult);
      $('.result-profit').text(profitResult);
    }else{
      var feeDefault = $('.result-fee').text();
      var profitDefault = $('.result-profit').text();
      var feeResult = feeDefault.replace(feeDefault, "-");
      var profitResult = profitDefault.replace(profitDefault, "-");
      $('.result-fee').text(feeResult);
      $('.result-profit').text(profitResult);
    }
  });
});