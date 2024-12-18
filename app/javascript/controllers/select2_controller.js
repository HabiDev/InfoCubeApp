import { Controller } from "@hotwired/stimulus"
import $ from "jquery";
import select2 from "select2";

export default class extends Controller {
  // static targets = [ "workload", "inputWorkload" ]
  
  initialize() {

    select2();

  }

  connect() {
    
    $.fn.select2.defaults.set( 'language', { 
      // You can find all of the options in the language files provided in the
      // build. They all must be functions that return the string that should be
      // displayed.
      noResults: function () { return "Совпадений не найдено" },
      
      errorLoading: function() { return"Невозможно загрузить результаты" },
      
      inputTooLong: function(e) { 
        var r = e.input.length-e.maximum, 
        u = "Пожалуйста, введите на " + r + " символ";
        return u += n(r, "", "a", "ов"), u += " меньше" },
      
      inputTooShort:  function(e) {
        var r = e.minimum-e.input.length,
        u = "Пожалуйста, введите ещё хотя бы " + r + " символ";
        return u += n(r,"","a","ов") },
      
      loadingMore: function() { return"Загрузка данных…" },
      
      maximumSelected: function(e) { 
        var r = "Вы можете выбрать не более " + e.maximum + " элемент";
        return r += n(e.maximum,"","a","ов") },
      
      searching: function() { return "Поиск…" },
      
      removeAllItems: function() { return "Удалить все элементы" }
      
    });
      
    // $('#select-card-sub-statement').select2({ dropdownParent: $('#modalNewEdit') });
    // $('#single-select-division-task').select2({ dropdownParent: $('#modalNewEdit') });
    // $('#single-select-subcategory-completed').select2();

    // $('#single-select-subcategory-completed').on('select2:select', function () {
    //   let event = new Event('change', { bubbles: true }); // fire a native event
    //   this.dispatchEvent(event);
    // });

    // $('#single-select-subcategory-work').select2({ dropdownParent: $('#modalTask') }); 
    // $('#single-select-division-task-search').select2();
    // $('#single-select-division-comp_task-search').select2();
    $('#order-product-group-select').select2(); 
    $('#order-product-select').select2(); 
    $('#order-provider-select').select2(); 
    $('#order-store-select').select2(); 
    $('#order-availability-order-select').select2(); 
    $('#order-to-order-select').select2({     
      multiple: true,
      allowClear: false  
    });   
    
    $('#order-to-order-select').siblings('.select2-container').append('<span class="select-all"><i class="fa-regular fa-square-check"></i></span>');
    $('#order-availability-order-select').siblings('.select2-container').append('<span class="select-all"><i class="fa-regular fa-square-check"></i></span>');
    $('#order-provider-select').siblings('.select2-container').append('<span class="select-all"><i class="fa-regular fa-square-check"></i></span>');
    $('#order-product-select').siblings('.select2-container').append('<span class="select-all"><i class="fa-regular fa-square-check"></i></span>');
    $('#order-product-group-select').siblings('.select2-container').append('<span class="select-all"><i class="fa-regular fa-square-check"></i></span>');
    $('#order-store-select').siblings('.select2-container').append('<span class="select-all"><i class="fa-regular fa-square-check"></i></span>');
     
    $('.select-all').on('click', function (e) {
      selectAllSelect2($(this).siblings('.selection').find('.select2-search__field'));
    });
        
    function selectAllSelect2(that) {
   
      var selectAll = true;
      var existUnselected = false;
      var item = $(that.parents("span[class*='select2-container']").siblings('select[multiple]'));
      
      item.find("option").each(function (k, v) {
        if (!$(v).prop('selected')) {          
          existUnselected = true;
          return false;
        }
         
      });
    
      selectAll = existUnselected ? selectAll : !selectAll; 
      
      item.find("option").prop('selected', selectAll);
      item.trigger('change');
    }

   
    
    
    // $('#single-select-sub_category-task-search').select2(); 

    // this.showWorkload();

  }

  // showWorkload(e) {
  //   let $isWorkload = $('#single-select-subcategory-completed').find(':selected').attr('status');
    
  //   if ( this.hasInputWorkloadTarget ) {
  //     if ( $isWorkload === 'true' ) { 
  //       this.inputWorkloadTarget.classList.remove('d-none'); 
  //     } else { 
  //       this.inputWorkloadTarget.classList.add('d-none');
  //     }
  //   }
  // }

}
