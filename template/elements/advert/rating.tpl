<div class="stars">

{* {$rating} *}
    {if $rating >= 5}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
   

    {elseif $rating >= 4.5 AND $rating < 5.0}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star star-half"></i>
   

    {elseif $rating >= 4 AND $rating < 4.5}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star star-empty"></i>
   

    {elseif $rating >= 3.5 AND $rating < 4.0}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star star-half"></i>
        <i class="star star-empty"></i>
   

    {elseif $rating >= 3.0 AND $rating < 3.5}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
   

    {elseif $rating >= 2.5 AND $rating < 3.0}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star star-half"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
       

    {elseif $rating >= 2.0 AND $rating < 2.5}
        <i class="star"></i>
        <i class="star"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
  

    {elseif $rating >= 1.5 AND $rating < 2.0}
        <i class="star"></i>
        <i class="star star-half"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>


    {elseif $rating >= 1.0 AND $rating < 1.5}
        <i class="star"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
    

    {else}
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
        <i class="star star-empty"></i>
    {/if}                

</div>