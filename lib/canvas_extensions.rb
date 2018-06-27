module CanvasExtensions
  PLATFORM = 'canvas.instructure.com'
  PLACEMENTS = [
    {key: :account_navigation, name: 'Account Navigation'},
    {key: :assignment_menu, name: 'Assignment Menu', type: 'select', options: [:content_item_selection, :basic_lti_request]},
    {key: :assignment_selection, name: 'Assignment Selection', type: 'select', options: [:content_item_selection_request, :basic_lti_request]},
    {key: :collaboration, name: 'Collaboration', type: 'select', options: [:content_item_selection_request, :basic_lti_request]},
    {key: :course_assignments_menu, name: 'Course Assignments Menu', type: 'select', options: [:basic_lti_request]},
    {key: :course_home_sub_navigation, name: 'Course Home Sub Navigation', type: 'input'},
    {key: :course_navigation, name: 'Course Navigation', type: 'input'},
    {key: :course_settings_sub_navigation, name: 'Course Settings Sub Navigation', type: 'input'},
    {key: :discussion_topic_menu, name: 'Discussion Menu', type: 'select', options: [:content_item_selection, :basic_lti_request]},
    {key: :editor_button, name: 'Editor Button', type: 'select', options: [:content_item_selection_request, :basic_lti_request]},
    {key: :file_menu, name: 'File Menu', type: 'select', options: [:content_item_selection, :basic_lti_request]},
    {key: :global_navigation, name: 'Global Navigation', type: 'input'},
    {key: :homework_submission, name: 'Homework Submission', type: 'select', options: [:content_item_selection_request, :basic_lti_request]},
    {key: :link_selection, name: 'Link Selection', type: 'select', options: [:content_item_selection_request, :basic_lti_request]},
    {key: :migration_selection, name: 'Migration Selection', type: 'select', options: [:content_item_selection_request, :basic_lti_request]},
    {key: :module_menu, name: 'Module Menu', type: 'select', options: [:content_item_selection, :basic_lti_request]},
    {key: :post_grades, name: 'Post Grades'},
    {key: :quiz_menu, name: 'Quiz Menu', type: 'select', options: [:content_item_selection, :basic_lti_request]},
    {key: :similarity_detection, name: 'Similarity Detection', type: 'select', options: [:basic_lti_request]},
    {key: :tool_configuration, name: 'Tool Configuration'},
    {key: :user_navigation, name: 'User Navigation'},
    {key: :wiki_page_menu, name: 'Wiki Page Menu', type: 'select', options: [:content_item_selection, :basic_lti_request]},
  ]
end
