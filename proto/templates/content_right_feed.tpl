        {if isset($id_logged)}
		<div class="notifications">
          <h3><a href="#">Notifications</a></h3>
          <ul class="notification-list list-unstyled">
            <li><a href="#">Maecenas aliquet eleifend nisl nec tincidunt.</a></li>
            <li><a href="#">Praesent tempor ac eros id iaculis. Suspendisse potenti.</a></li>
            <li><a href="#">Donec laoreet dui nec massa mollis, vel posuere metus sodales. Suspendisse dictum, ligula id scelerisque laoreet.</a></li>
            <li><a href="#">Sed non commodo urna. Ut vehicula ornare ipsum a malesuada.</a></li>
          </ul>
        </div>

        <div class="recent-news">
          <h3><a href="#">Recent News </a></h3>
          <p>{$news.body}</p>
          <div class="read-more"><a href="{$news.moreInfo}" target="_blank">Read more...</a></div>
        </div>
		{/if}