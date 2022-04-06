% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Nhận Tâm Hồn Thống Hối" }
  composer = "Đn. 3,26-27.29.34-41"
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
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 4 c8 (d) |
  g4. f16 g |
  af8 c, d g |
  f4 r8 f16 f |
  d8 d g d |
  c4. bf16 c |
  ef8 f d d |
  g4 r8 g |
  c4. c16 af |
  f4. g8 |
  c, (ef) g8 af |
  g4. ef16 ef |
  f4. g8 |
  g8. ef16 d8 g |
  c,2 \bar "||"
  
  \pageBreak
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key c \major
  e4. f8 |
  d8 d c a' |
  a4.g16 g |
  g8 a c c |
  b2 |
  d4. e16 b |
  c4. a8 |
  g4.  d16 d |
  d8 e a f |
  g4 r8 g |
  e4. f8 |
  d e c a' |
  a4. g8 |
  g g a (c) |
  b4. g8 |
  d'4. e16 b |
  c4. a8 |
  g4. d16 d |
  f8 g e d |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*14
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key c \major
  c4. d8 |
  b b c f |
  f4. f16 f |
  e8 f a a |
  g2 |
  fs4. g16 g |
  e4. f8 |
  e4. b16 b |
  b8 c c d |
  b4 r8 b |
  c4. d8 |
  b c c f |
  f4. f8 |
  e e d (a') |
  g4. g8 |
  fs4. g16 g |
  e4. f8 |
  e4. b16 b |
  d8 e c b |
  c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa là Thiên Chúa tổ tiên chúng con,
      Xin ca ngợi và tán dương Ngài,
      Hiển vinh danh thánh Ngài ngàn kiếp.
      Vì trong mỗi sự việc Chúa làm cho chúng con
      đều tỏ ra Chúa rất công bình chính trực.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lầm lỗi, đoàn con đã làm điều ác gian,
	    khi cam lòng tìm lánh xa Ngài,
	    thật là sai lỗi nặng nề quá,
	    Nhưng Chúa chớ bỏ mặc, chớ hủy Giao ước xưa
	    dủ tình thương nhớ tới danh cực thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tưởng nhớ tình thân với tổ phụ chúng con,
	    nay xin Ngài đừng nỡ thu hồi
	    Lòng thương yêu Chúa đã dành sẵn,
	    Ngài đã hứa sẽ làm giống dòng tăng số lên,
	    tựa trời sao, giống cát trên bờ biển dài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lạy Chúa, vì tội lỗi mà nay chúng con
	    nên dân tộc nhỏ nhất trên đời,
	    ở mọi nơi nếm mùi nhục nhã,
	    Chẳng có cấp lãnh đạo, chẳng gặp ngôn sứ đâu,
	    người chỉ huy vắng bóng trên phần đất này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lạy Chúa, ngày nay lễ toàn thiêu có đâu,
	    Bao sinh vật thượng tiến không còn,
	    Tàn lụi hương khói ở mọi chốn,
	    Của lễ lúc khai mùa biết đặt đâu tiến dâng,
	    để đoàn con đáng Chúa thương lại đoái nhìn.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Xin Chúa nhận tâm hồn thống hối,
  và lòng thành khiêm ái chúng con thay lễ toàn thiêu chiên bò,
  và ngàn vạn cừu béo thịt ngon,
  Ước mong lễ thượng tiến Ngài hôm nay làm đẹp lòng Chúa luôn.
  Vì ai vững cậy tin nơi Ngài thì nào phải thất vọng ê chề.
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
  \key ef \major \time 2/4
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
