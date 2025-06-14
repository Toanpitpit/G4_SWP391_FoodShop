       <div class="blog-container">
                    <main class="main-content">
                        
                        <div class="content-wrapper">
                            <h1 class="blog-title">${blog.title}</h1>
                            <img src="${blog.imageUlr}" alt="Online Shopping" class="hero-image">
                            <div class="meta-info">
                                <div class="author-info">
                                    <div class="author-avatar">EP</div>
                                    <span class="author-name">${blog.authorName}</span>
                                </div>
                                <span class="publish-date"><fmt:formatDate
                                        value="${blog.update_at}"
                                        pattern="yyyy-MM-dd HH:mm:ss" />
                                </span>
                                <span class="blog-tag">Test</span>
                            </div>
                            <div class="blog-content">
                                ${blog.content}
                            </div>
                    </main>

                    <aside class="sidebar">
                        <h2 class="sidebar-title">Bài vi?t liên quan</h2>
                        <article class="related-post">
                            <c:forEach var="post" items="${relatedBlogs}">
                                <a href="blog/detail?id=${post.id}" class="related-link">
                                    <div class="related-item">
                                        <img src="${post.imageUrl}" alt="${post.title}" class="related-image" />
                                        <div class="related-content">
                                            <h3 class="related-title">${post.title}</h3>
                                            <span class="related-tag">${post.bmiId}</span>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </article>
                    </aside>
                </div>
