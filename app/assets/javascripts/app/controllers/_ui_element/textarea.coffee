# coffeelint: disable=camel_case_classes
class App.UiElement.textarea
  @render: (attribute) ->
    fileUploaderId = 'file-uploader-' + new Date().getTime() + '-' + Math.floor( Math.random() * 99999 )
    item = $( App.view('generic/textarea')( attribute: attribute ) + '<div class="file-uploader ' + attribute.class + '" id="' + fileUploaderId + '"></div>' )

    a = ->
      visible = $( item[0] ).is(':visible')
      if visible && !$( item[0] ).expanding('active')
        $( item[0] ).expanding()
      $( item[0] ).on('focus', ->
        visible = $( item[0] ).is(':visible')
        if visible && !$( item[0] ).expanding('active')
          $( item[0] ).expanding().focus()
      )
    App.Delay.set(a, 80)

    if attribute.upload

      # add file uploader
      u = ->

        # only add upload item if html element exists
        if $('#' + fileUploaderId )[0]
          $('#' + fileUploaderId ).fineUploader(
            request:
              endpoint: App.Config.get('api_path') + '/ticket_attachment_upload'
              params:
                form_id: item.closest('form').find('[name=form_id]').val()
            text:
              uploadButton: App.Utils.icon('paperclip')
            template: '<div class="qq-uploader">' +
                        '<pre class="btn qq-upload-icon qq-upload-drop-area"><span>{dragZoneText}</span></pre>' +
                        '<div class="btn btn-default qq-upload-icon2 qq-upload-button pull-right" style="">{uploadButtonText}</div>' +
                        '<ul class="qq-upload-list span5" style="margin-top: 10px;"></ul>' +
                      '</div>',
            classes:
              success: ''
              fail:    ''
            debug: false
          )
      App.Delay.set(u, 100, undefined, 'form_upload')
    item