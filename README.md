# README

This README would normally document whatever steps are necessary to get the
application up and running.

ER図構成

Users
 |Columns        |Description|
 |name           |string     |
 |email          |string     |
 |password_digest|string     |

Tasks
 |user_id        |brignt     |
 |title          |string     |
 |content        |text       |

Labels-Tasks
 |task_id        |brignt     |
 |user_id        |brignt     |

Labels 
 |name           |string     | 
 