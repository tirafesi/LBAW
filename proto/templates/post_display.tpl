<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

  	<title>LBAW</title>

    <!-- Bootstrap -->
    <link href="../../lib/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="../../lib/bootstrap-3.3.7/css/bootstrap-select.min.css">
    <!-- Default stylesheet -->
    <link href="../../css/profile.css" rel="stylesheet">
    <link href="../../css/default.css" rel="stylesheet">
	<link rel="stylesheet" href="../../lib/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
</head>

<body>

{include file='header.tpl'}

{if empty($page_not_found)}
<div class="container">
    <div class="row">
		<div class="col-md-3 pull-md-9 hidden-xs hidden-sm">
			<div class="user_bar affix">
				<div class="user_info">
					<a href="profile_feed.php?user-id={$id}"><img class="centered-and-cropped" src="{$image.url}" alt="{$image.description}"></a>
					<h3>{$character.name}</h3>
					<ul class="list-unstyled">
						<li>
							<span class="glyphicon glyphicon-user"></span>
							<b>Character is</b> <a href="{$character.url}">{$character.name}</a>
						</li>
						<li>
							<span class="glyphicon glyphicon-book"></span>
							<b> Series is</b> <a href="{$series.url}">{$series.name}</a>
						</li>
					</ul>
					{if !($id == $id_logged) && isset($username_logged)}
						{if !($friendship)}
						<form action="../../actions/users/friendship.php" method="post">
							<button name="user2-id" value="{$id}" type="submit" class="btn btn-default">Add friend <span class="glyphicon glyphicon-plus"></span></button>
						</form>
						{else}
							{if ($friend.accepted)}
								{if ($friend.user1 == $id)}
									<div class="dropdown">
										<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><span class="glyphicon glyphicon-ok"></span> Friends</button>
										<ul class="dropdown-menu">
											<li>
												<form id="unfriend-form" action="../../actions/users/delete_friendship.php" method="post">
													<input type="hidden" name="cancel" value="false">
													<input type="hidden" name="user1-id" value="{$id}">
													<a href="javascript:void(0)" onclick="document.getElementById('unfriend-form').submit(); return false;">Unfriend</a>
												</form>
											</li>
										</ul>
									</div>
								{else}
									<div class="dropdown">
										<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><span class="glyphicon glyphicon-ok"></span> Friends</button>
										<ul class="dropdown-menu">
											<li>
												<form id="unfriend-form" action="../../actions/users/delete_friendship.php" method="post">
													<input type="hidden" name="cancel" value="true">
													<input type="hidden" name="user2-id" value="{$id}">
													<a href="javascript:void(0)" onclick="document.getElementById('unfriend-form').submit(); return false;">Unfriend</a>
												</form>
											</li>
										</ul>
									</div>
								{/if}
							{else}
								{if ($friend.user1 == $id)}
									<div class="dropdown">
										<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><span class="glyphicon glyphicon glyphicon-user"></span> Accept request</button>
										<ul class="dropdown-menu">
											<li>
												<form id="confirm-form" action="../../actions/users/accept_friendship.php" method="post">
													<input type="hidden" name="user1-id" value="{$id}">
													<a href="javascript:void(0)" onclick="document.getElementById('confirm-form').submit(); return false;">Confirm</a>
												</form>
											</li>
											<li>
												<form id="delete-form" action="../../actions/users/delete_friendship.php" method="post">
													<input type="hidden" name="cancel" value="false">
													<input type="hidden" name="user1-id" value="{$id}">
													<a href="javascript:void(0)" onclick="document.getElementById('delete-form').submit(); return false;">Delete</a>
												</form>
											</li>
										</ul>
									</div>
								{else}
									<form action="../../actions/users/delete_friendship.php" method="post">
										<input type="hidden" name="cancel" value="true">
										<input type="hidden" name="user2-id" value="{$id}">
										<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-minus"></span> Cancel request</button>
									</form>
								{/if}
							{/if}
						{/if}
					{/if}
				</div>

				{if ($id == $id_logged) || $public  || $friend.accepted}
				{if !empty($previousimg) || !empty($nextimg)}
				<div class="user_photos">
					<h3><b>Photos</b></h3>
					{if !empty($previousimg)}
					<figure class="imgContainer">
						<a href="post_display.php?user-id={$id}&post-id={$previousimg.id}"><img class="centered-and-cropped thumb-100px" src="{$previousimg.url}" alt="{$previousimg.description}"></a>
						<figcaption><a href="post_display.php?user-id={$id}&post-id={$previousimg.id}">Previous</a></figcaption>
					</figure>
					{/if}

					{if !empty($nextimg)}
					<figure class="imgContainer">
						<a href="post_display.php?user-id={$id}&post-id={$nextimg.id}"><img class="centered-and-cropped thumb-100px" src="{$nextimg.url}" alt="{$nextimg.description}"></a>
						<figcaption><a href="post_display.php?user-id={$id}&post-id={$nextimg.id}">Next</a>
					</figure>
					{/if}
				</div>
				{/if}{/if}
			</div>
		</div>
        <div class="col-md-9 push-md-3">
			{if ($id == $id_logged) || $public || $friend.accepted}
			<div class="timeline">

				{if !empty($post)}
				<div class="photo-display">
					<div id="black" class="black_overlay"></div>

					<div id="edit-{$post.postid}" class="edit_box">
						<a href="javascript:void(0)" id="close-edit-{$post.postid}" class="close-edit pull-right">
						<span class="close glyphicon glyphicon-remove"></span></a>

						<div class="poster">
							<p><a href="profile_feed.php?user-id={$id_logged}"><img src="{$post.charurl}" alt="Profile picture of {$post.charname}" class="centered-and-cropped thumb-32px">
								<span>{$post.charname}</span></a>
								<br><span class="post-date">{$post.date|date_format}</span>
							</p>
						</div>

						<form class="form" action="../../actions/posts/edit_post.php" method="post">
							<div class="wrapper">
								<input type="hidden" name="user-id" value="{$id_logged}">
								<input type="hidden" name="post-id" value="{$post.postid}">
								{if !empty($post.url)}
								<textarea name="body" class="form-control" rows="5">{$post.body}</textarea>
								{else}
								<textarea name="body" class="form-control" rows="5" required>{$post.body}</textarea>
								{/if}
								<div class="controls">
									<select name="public" class="selectpicker" data-width="fit">
										{if $post.public}
											<option data-icon="glyphicon-globe" value="t" selected="selected">Public</option>
											<option data-icon="glyphicon-lock" value="f" >Private</option>
										{else}
											<option data-icon="glyphicon-globe" value="t">Public</option>
											<option data-icon="glyphicon-lock" value="f" selected="selected">Private</option>
										{/if}
									</select>
									<button class="update" type="submit">Update post</button>
								</div>
							</div>
						</form>
					</div>

					<div id="confirm-{$post.postid}" class="edit_box">
						<div class="modal-body">Are you sure you want to delete this post?</div>
							<div class="modal-footer button-container">
								<form class="form" action="../../actions/posts/delete_post.php" method="post">
									<input type="hidden" name="post-id" value="{$post.postid}">
									<input type="hidden" name="feed" value="false">
									<button type="button" id="close-delete-{$post.postid}" class="close-delete btn">Cancel</button>
									<input type="submit" class="btn btn-primary" value="Delete">
								</form>
							</div>
					</div>

					<div class="post-body">
						{if $post.user == $id_logged || $isWebPageAdmin === '1'}
						<div class="dropdown pull-right">
							<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><span class="glyphicon glyphicon-chevron-down"></span></button>
							<ul class="dropdown-menu">
								<li id="edit-post-{$post.postid}" class="edit"><a href="javascript:void(0)">Edit</a></li>
								<li id="delete-post-{$post.postid}" class="delete"><a href="javascript:void(0)">Delete</a></li>
							</ul>
						</div>
						{/if}

						<div class="poster">
							<p><a href="profile_feed.php?user-id={$post.user}"><img src="{$post.charurl}" alt="Profile picture of {$post.charname}" class="centered-and-cropped thumb-32px"></a>
							<a href="profile_feed.php?user-id={$post.user}">{$post.charname}</a>
								<br><span class="post-date">{$post.date|date_format}</span>
							</p>
						</div>

						<div class="post-content">
							{$post.body}
							{if !empty($post.url)}
							<img src="{$post.url}" alt="{$post.description}" class="ph_display">
							{/if}
						</div>
					</div>
				
					<div class="opt-group btn-group-justified">
						<a href="#" class="btn btn-default post-opt"><span class="glyphicon glyphicon-heart"></span> Like <span class="badge">{$post.likes}</span></a>
						<a href="#" class="btn btn-default post-opt"><span class="glyphicon glyphicon-comment"></span> Comment <span class="badge">{$post.comments}</span></a>
					</div>

					{if ((isset($username_logged) && $friendship) || ($id == $id_logged))}
					<hr class="separator">

					<div class="make-comment-wrap">
						<form class="form" action="../../actions/posts/comment.php" method="post">
							<div class="form-group">
								<input type="hidden" name="post-id" value="{$post.postid}">
								<input type="hidden" name="user-id" value="{$id_logged}">
								<label for="make-comment-{$post.postid}" class="sr-only">Write a comment</label>
								<textarea id="make-comment-{$post.postid}" name="body" class="form-control txtarea-comment" rows="1" placeholder="Write something..."></textarea>
							</div>
							<button type="submit" class="btn btn-default btn-comment">Comment</button>
						</form>
					</div>
					{/if}
				</div>

				{foreach $comments as $comment}
					<div class="comment">

						<div id="edit-comment-{$comment.comid}" class="edit_box">
							<a href="javascript:void(0)" id="close-comment-{$comment.comid}" class="close-comment pull-right">
							<span class="close glyphicon glyphicon-remove"></span></a>

							<div class="poster">
								<p><a href="profile_feed.php?user-id={$comment.userid}"><img src="{$comment.url}" alt="Profile picture of {$comment.name}" class="centered-and-cropped thumb-32px">
									<span>{$comment.name}</span></a>
								</p>
							</div>
							<br>
							<form class="form" action="../../actions/posts/change_comment.php" method="post">
								<div class="wrapper">
									<input type="hidden" name="comment-id" value="{$comment.comid}">
									<input type="hidden" name="post-id" value="{$postid}">
									<textarea name="body" class="form-control" rows="3" required>{$comment.body}</textarea>
									<div class="controls">
										<button class="update" type="submit">Update comment</button>
									</div>
								</div>
							</form>
						</div>

						<div id="confirm-comment-{$comment.comid}" class="edit_box">
							<div class="modal-body">Are you sure you want to delete this comment?</div>
								<div class="modal-footer button-container">
									<form class="form" action="../../actions/posts/delete_comment.php" method="post">
										<input type="hidden" name="comment-id" value="{$comment.comid}">
										<input type="hidden" name="post-id" value="{$postid}">
										<button type="button" id="close-delete-comment-{$comment.comid}" class="close-delete-comment btn">Cancel</button>
										<input type="submit" class="btn btn-primary" value="Delete">
									</form>
								</div>
						</div>

						{if $comment.userid == $id_logged}
						<div class="dropdown pull-right">
							<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
							<span class="glyphicon glyphicon-chevron-down"></span></button>
							<ul class="dropdown-menu">
								<li id="edit-com-{$comment.comid}" class="edit-comment"><a href="javascript:void(0)">Edit</a></li>
								<li id="delete-com-{$comment.comid}" class="delete-comment"><a href="javascript:void(0)">Delete</a></li>
							</ul>
						</div>
						{/if}
						<div class="comment-poster">
							<a href="profile_feed.php?user-id={$comment.userid}"><img src="{$comment.url}" class="centered-and-cropped thumb-32px" alt="Profile picture of {$comment.name}"><b>{$comment.name}</b></a>
						</div>

						<p>{$comment.body}</p>

						<a href="#"><span class="glyphicon glyphicon-heart"></span> {$comment.likes}</a>
					</div>
				{/foreach}
				{else}
					<h3>Post not found!</h3>
				{/if}
			</div>
			{else}
			<div id="private-profile">
				<h2>This profile is private.</h2>
				<h4>Become friends with this user to see their posts!</h4>
			</div>
			{/if}
		</div>

        <div class="col-xs  hidden-xs hidden-sm">
        </div>
    </div>
</div>
{else}
<div id="not-found"><h1>{$page_not_found}</h1></div>
{/if}

	{include file='footer.tpl'}

	<!-- Placed at the end of the document so the pages load faster -->
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="../../lib/jquery-3.1.1.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../../lib/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="../../lib/bootstrap-3.3.7/js/bootstrap-select.min.js"></script>
	<script src="../../javascript/script.js"></script>
	<script src="../../javascript/search-bar.js"></script>
</body>
</html>
