-- Finds and lists all of the TODO, HACK, BUG, etc comment
-- in your project and loads them into a browsable list.
-- FIX：需要修复的问题
-- TODO：待办任务
-- HACK：临时解决方案
-- WARN：警告或需要注意的地方
-- PERF：性能优化点
-- NOTE：额外信息或注释
-- TEST：测试相关的内容
return {
	"folke/todo-comments.nvim",
	lazy = true,
	event = "LazyFile",
	opts = {},
}
