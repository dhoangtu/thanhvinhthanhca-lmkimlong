% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Dò Xét Con" }
  composer = "Tv. 25"
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
  \partial 4 g8 d |
  bf'8. a16 g8 (bf) |
  c2 |
  d8. d16 ef8 d |
  c8 c4 c8 |
  bf8. d16 g,8 a ~ |
  a4 g8 a16 (g) |
  ef8. d16 bf'8 a |
  c2 |
  d8. d16 ef8 c ~ |
  c d bf4 |
  a8. a16 bf8 g ~ |
  g4 \bar "||" \break
  
  g8 g |
  ef4 c8 c |
  d4. d8 |
  a'8. a16 bf8 a ~ |
  a g a g |
  fs2 ~ |
  fs4 g8 g |
  ef4 d8 (g) |
  a4. c8 |
  c8. c16 bf8 a ~ |
  a a bf fs |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 d |
  bf'8. a16 g8 (bf) |
  c2 |
  bf8. bf16 c8 bf |
  a a4 a8 |
  g8. f16 ef8 d ~ |
  d4 g8 a16 (g) |
  ef8. d16 bf'8 a |
  c2 |
  bf8. bf16 g8 a ~ |
  a f g4 |
  d8. d16 c8 bf ~ |
  bf4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Xin dò xét và thử con,
  xin nung đúc tâm can con,
  tôi luyện trí lòng con.
  Ân nghĩa Ngài ở trước mặt con
  Nên con vững tâm bước đi trong chân lý Ngài.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Xin phân xử mọi việc con
      vì con luôn bước đi theo đức trọn lành.
      Con tin tưởng vào Chúa nên con không do dự,
      nào núng chuyển lay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Quân gian xảo, bọn tà tâm,
	    phường vô luân bất trung con quyết xa lìa,
	    Tay con rửa thuần khiết hân hoan
	    lên bàn thờ vang tiếng tạ ơn.
	    
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con mong mỏi được truyền rao kỳ công
	    ôi xiết bao tay Chúa đã làm.
	    Con yêu chuộng nhà Chúa,
	    nơi vinh quang tỏa rạng nơi Chúa hiển linh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con ăn ở thực thẳng ngay,
	    Ngài ra tay cứu nguy thương xót con cùng.
	    Luôn thanh thản nhẹ bước,
	    ca vang nơi công hội vinh chúc Ngài liên.
    }
  >>
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key bf \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
