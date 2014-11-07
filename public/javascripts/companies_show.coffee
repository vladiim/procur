$( document ).ready( ->

  $( '.service' ).on 'click', ( event ) ->
    $target = $( event.target )
    service = $target.data( 'service' )
    $( ".#{ service }-show" ).toggleClass 'hidden'

  $( '.profile-pic' ).popover({
    title: '<a href="/">Vlad Mehakovic</a>',
    html: 'true',
    content: "Head of CX, Holler"
  })

  $( '.profile-pic' ).on 'click', ( event ) ->
    $( '.profile-pic' ).not( this ).popover( 'hide' )

  $( '.btn-vote' ).on 'click', ( event ) ->
    event.preventDefault()
    $target = $( event.target )
    if $target.hasClass( 'btn-vote' )
      $num = $target.find('b')
    else
      $num = $target.parent( '.btn-vote' ).find('b')
    val = parseInt( $num.text() )
    $num.text( val++ )
)