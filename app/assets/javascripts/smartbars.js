$(document).ready(function() {

    function displaySpecifiedPositionElement() {
        if ($('#smartbar_position_element_other:checked').length > 0) {
            $('#specified-smartbar-position-element').show();
        } else {
            $('#specified-smartbar-position-element').hide();
            $('#smartbar_position_element').val('body');
        }
    }
    displaySpecifiedPositionElement();

    function displayRuleGrouping() {
        if ($('.smartbar-rule.persisted, .smartbar-rule.new').length > 1) {
            $('#smartbar-rules-grouping').show();
        } else {
            $('#smartbar-rules-grouping').hide();
        }
    }
    displayRuleGrouping();

    $('#smartbar_position_element_other, #smartbar_position_element_body').on('change', function() {
        displaySpecifiedPositionElement();
    });

    $('form').on('click', '.add-fields', function(e) {
        var time = new Date().getTime(),
            regexp = new RegExp($(this).data('id'), 'g');
        $(this).parent().before($(this).data('fields').replace(regexp, time));
        displayRuleGrouping();
        e.preventDefault();
    });

    $('form').on('click', '.remove-fields', function(e) {
        $(this).prev("input[type='hidden']").val("1");
        $(this).closest('.smartbar-rule').removeClass('persisted new').hide();
        displayRuleGrouping();
        e.preventDefault();
    })

    $('form').on('change', '.rule-type-select', function(e) {
        var selectedRuleTypeId = $(this).val(),
            $extraControls = $(this).parents('.controls').find('.extra-controls');

        $.each($extraControls.data('label-values'), function(index, rt) {
            if (parseInt(rt['id'], 10) == parseInt(selectedRuleTypeId, 10) ) {
                if (rt['default_value'] !== null) {
                    $extraControls.find('.rule_value input').val(rt['default_value']);
                }
                if (rt['value_label'] !== null) {
                    $extraControls.find('.rule-value label').text(rt['value_label']);
                    $extraControls.find(".rule-value").css('visibility', 'visible');
                    $extraControls.find('.rule-value').show();
                } else {
                    $extraControls.show();
                    $extraControls.find(".rule-value").css('visibility', 'hidden').show();
                }
                return;
            }
        });
    });
});
