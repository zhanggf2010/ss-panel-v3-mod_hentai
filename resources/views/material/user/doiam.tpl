{include file='user/main.tpl'}
	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">捐贈公示</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">


					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<p>感謝各位捐贈來支撐服務器的日常支出！您可以在<a href="/user/code">充值界面</a>進行充值，這樣就等同于捐贈了。</p>
									{if $user->isAdmin()}
									<p>總收入：{$total_in} 元</p>
									{/if}

								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">匿名捐贈</p>
										<p>當前設置：{if $user->is_hide==1} 匿名 {else} 不匿名 {/if}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="hide">匿名設置</label>
											<select id="hide" class="form-control">
												<option value="1">匿名</option>
												<option value="0">不匿名</option>
											</select>
										</div>

									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="hide-update" ><span class="icon">check</span>&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<div class="card-table">
											<div class="table-responsive">
												{$codes->render()}
												<table class="table table-hover">
													<tr>
														<th>ID</th>
														<th>用戶名</th>
														<th>類型</th>
														<th>操作</th>
														<th>備注</th>
														<th>時間</th>

													</tr>
													{foreach $codes as $code}
														<tr>
															<td>#{$code->id}</td>
															{if $code->user() != null && $code->user()->is_hide == 0}
															<td>{$code->user()->user_name}</td>
															{else}
															<td>用戶匿名或已注銷</td>
															{/if}
															{if $code->type == -1}
															<td>充值捐贈</td>
															{/if}
															{if $code->type == -2}
															<td>財務支出</td>
															{/if}
															{if $code->type == -1}
															<td>捐贈 {$code->number} 元</td>
															{/if}
															{if $code->type == -2}
															<td>支出 {$code->number} 元</td>
															{/if}
															<td>{$code->code}</td>
															<td>{$code->usedatetime}</td>
														</tr>
													{/foreach}
												</table>
												{$codes->render()}
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>

					{include file='dialog.tpl'}
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}

<script>
    $(document).ready(function () {
        $("#hide-update").click(function () {
            $.ajax({
                type: "POST",
                url: "hide",
                dataType: "json",
                data: {
                    hide: $("#hide").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+" 出錯啦！");
                }
            })
        })
    })
</script>
