% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Cao Trọng Lắm Thay" }
  composer = "Tv. 39"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8. g16 e8 c |
  f4. e8 |
  a8. a16 f8 d |
  g4 c8 b16 (c) |
  e8 c a c |
  g4 \slashedGrace { d16 _( } g8) e16 (d) |
  c4 e' ~ |
  e8 d b d |
  c2 \bar "||" \break
  
  g8. c,16 d8 e |
  f (e) d g |
  g4 r8 g |
  e'
  \afterGrace a,8 ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  a8 c |
  d2 |
  d8. d16 b (a) g8 |
  c4 \slashedGrace { a16 ( } c8) a16 (g) |
  f4 f8 d |
  g8. c,16 d8 d |
  e2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8. g16 e8 c |
  f4. e8 |
  a8. a16 f8 d |
  g4 e8 d16 (e) |
  g8 a f f |
  e4 b8 b |
  c4 c' ~ |
  c8 g g f |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Hỡi những ai tìm Chúa,
  nào hãy hớn hở mừng vui.
  Ai cảm mến ơn Ngài tế độ nói lên rằng:
  Chúa cao trọng lắm thay!
  <<
    {
      \set stanza = "1."
      Chúa là nơi con vẫn cậy trông liên,
      Ngài đoái nhận lời con kêu,
      Cứu thoát khỏi bùn nhơ, hố hủy diệt,
      cho đặt chân vào nơi kiên vững.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hát mừng lên Thiên Chúa bài tân ca,
	    Và hãy một lòng cậy tin,
	    Phúc đức ai tựa nương ở nơi Ngài,
	    không hùa theo phường gian kiêu hãnh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Những kỳ công tay Chúa làm cho con,
	    thực quá lạ lùng khôn sánh,
	    Lắm lúc con hồi tâm muốn kể lại,
	    nhưng nhiều quá kể sao cho xiết.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa chẳng ưa hy lễ cùng hiến tế,
	    Ngài đã mở rộng tai con,
	    Lễ xóa tội toàn thiêu Chúa chẳng đòi,
	    con liền thưa: này con xin đến.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Giữa đoàn dân con sẽ truyền tin vui,
	    Quảng bá rằng Ngài công minh,
	    Đức tín trung cùng với phúc cứu độ,
	    con chẳng giấu để riêng con biết.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa đừng ngơi âu yếm cảm thương con,
	    Nguyện mãi độ trì chở che,
	    Những khó nguy bủa vây khắp quanh mình,
	    tai vạ cứ nhằm con tuôn tới.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Kiếp lầm than nguy khó của con đây
	    Ngài đã dủ tình trông đến,
	    Đấng cứu nguy hộ giúp, Chúa con thờ,
	    xin Ngài đến đừng khoan lơi nữa.
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
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 0.5)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
    %\override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
