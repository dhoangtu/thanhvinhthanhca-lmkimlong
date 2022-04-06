% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Cho Con Đức Khôn Ngoan" }
  composer = "Kn. 9,1-5,9-11"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g16 fs |
  b8. e,16 \tuplet 3/2 { g8 g a } |
  d,4. d8 |
  d fs4 g8 |
  \slashedGrace { a16 (b } a4) \tuplet 3/2 { c8 c a } |
  a8. a16 \tuplet 3/2 { e'8 d d } |
  b4 \tuplet 3/2 { g8 c b } |
  a8. fs16 \tuplet 3/2 { a8 g e } |
  d4 r8 \bar "||" \break
  
  b'16 b |
  b4. c16 b |
  a8. g16 \tuplet 3/2 { g8 a b } |
  d,4 \tuplet 3/2 { d8 fs g } |
  a8. a16 \tuplet 3/2 { e'8 cs cs } |
  d4 r8 b16 b |
  b4. c16 (b) |
  a8. g16 \tuplet 3/2 { g8 a b } |
  \slashedGrace { d,16 (e } d4) \tuplet 3/2 { d8 fs g } |
  a8. e16 \tuplet 3/2 { a8 b g } |
  g2 ~ |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*7
  r4.
  g16 g |
  g4. a16 g |
  d8. e16 \tuplet 3/2 { e8 c c } |
  b4 \tuplet 3/2 { b8 d e } |
  d8. fs16 \tuplet 3/2 { g8 a g } |
  fs4 r8 g16 g |
  g4. a16 (g) |
  d8. e16 \tuplet 3/2 { e8 c c } |
  \once \stemUp
  \once \override NoteColumn.force-hshift = #0.1
  b4 \tuplet 3/2 { b8 d e } |
  d8. d16 \tuplet 3/2 { c8 c b } |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Muôn lạy Chúa tổ tiên con kính thờ,
      Ngài từ bi lân tuất,
      Chúa phán một lời là tác sinh muôn loài,
      Dùng Đức Khôn Ngoan mà nắn nên con người.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con người đó Ngài trao cho
	    lãnh đạo mọi vật Ngài tạo tác
	    Hãy sống thiện toàn và đoán phân công bình,
	    Lòng trí đơn ngay, phải trái luôn minh bạch.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cho dù có một ai nơi thế trần,
	    dù thập toàn đi nữa,
	    Nếu đã chẳng nhận được đức khôn ngoan Ngài,
	    Thì có ra chi, kể cũng như không vậy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Công việc Chúa Sự Khôn Ngoan thấu tường,
	    vì ở gần bên Chúa,
	    vẫn đã hiện diện hồi tác sinh muôn loài,
	    Hiểu biết những chi hợp với huấn lệnh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Xin gửi tới Sự Khôn Ngoan của Ngài
	    từ trời cao tôn thánh,
	    phái đến từ tòa rực ánh vinh quang Ngài,
	    Cộng tác với con làm Chúa luôn vui lòng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ôi lạy Chúa, Sự Khôn Ngoan của Ngài,
	    mọi việc đều thông suốt,
	    khéo léo thận trọng chỉ dẫn con thi hành,
	    Và lấy uy linh gìn giữ con khôn rời.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Xin cho con Đức Khôn Ngoan hằng ngự bên hữu Ngài,
  Đừng đuổi con đi mà chẳng nhận làm con.
  Thân con đây, Chúa ơi, đời mỏng manh vắn vỏi,
  là phận tôi tớ, là con nữ tỳ Ngài.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
